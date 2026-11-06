//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_skins
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player skins from profile `textures` properties: authlib's
//! `MinecraftServicesSessionService.unpackTextures`, vanilla's
//! `SkinManager` lookup (which texture a player shows, and when the default
//! one) and `SkinTextureDownloader.processLegacySkin`.

/// `Property.hasSignature` and the services key check, as authlib's
/// `SignatureState`.
pub const Signature = enum {
    Unsigned,
    Signed,
    Invalid,
};

/// `MinecraftProfileTextures`: the texture URLs a profile names. Empty when
/// the payload doesn't decode or names a URL outside the allowed domains.
pub const Textures = struct {
    skin: ?[]const u8,
    /// The skin's `metadata.model` is `slim` (`PlayerModelType.SLIM`).
    slim: bool,
    cape: ?[]const u8,
    elytra: ?[]const u8,
    signed: bool,
};

/// The `getTexture` endpoint's valid URIs from Minecraft services discovery.
    // rust: pub const TEXTURE_URIS: [&str; 2] = [
    // rust: "https://textures.minecraft.net/texture/{textureId}",
    // rust: "http://textures.minecraft.net/texture/{textureId}",
    // rust: ];

/// `java.util.Base64.getDecoder().decode`.
pub fn base64_decode(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use base64::{
    // rust: Engine,
    // rust: engine::general_purpose::{STANDARD, STANDARD_NO_PAD},
}
    // rust: STANDARD
    // rust: .decode(text)
    // rust: .or_else(|_| STANDARD_NO_PAD.decode(text))
    // rust: .ok()
}

/// `unpackTextures(property)`: the textures of a `textures` property's
/// base64 JSON payload.
pub fn unpack(value: []const u8, signature: Signature, valid_uris: *[[]const u8]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let empty = Textures::default();
    // rust: let Some(json) = base64_decode(value)
    // rust: .map(|b| String::from_utf8_lossy(&b).into_owned())
    // rust: .and_then(|s| serde_json::from_str::<serde_json::Value>(&s).ok())
    // rust: else {
    // rust: return empty;
}
    // rust: let Some(textures) = json.get("textures").and_then(|t| t.as_object()) else {
    // rust: return empty;
}
    // rust: if textures.is_empty() {
    // rust: return empty;
}
    // rust: let mut out = Textures {
    // rust: signed: signature == Signature::Signed,
    // rust: ..empty.clone()
}
    // rust: for (kind, texture) in textures {
    // rust: let Some(url) = texture.get("url").and_then(|u| u.as_str()) else {
    // rust: return empty;
}
    // rust: let allowed = valid_uris
    // rust: .iter()
    // rust: .any(|u| url.starts_with(&u.replace("{textureId}", "")));
    // rust: if !allowed {
    // rust: return empty;
}
    // rust: if kind == "SKIN" {
    // rust: out.slim = texture
    // rust: .get("metadata")
    // rust: .and_then(|m| m.get("model"))
    // rust: .and_then(|m| m.as_str())
    // rust: == Some("slim");
}
    // rust: let slot = match kind.as_str() {
    // rust: "SKIN" => &mut out.skin,
    // rust: "CAPE" => &mut out.cape,
    // rust: "ELYTRA" => &mut out.elytra,
    // rust: _ => continue,
}
    // rust: *slot = Some(url.to_owned());
}
    // rust: out
}

/// The skin URL of a `minecraft:profile` component's property list. Player
/// heads and mannequins read their profile this way, and `SkinManager` lets
/// those textures be unsigned (`getInsecureSkinInformation`).
pub fn profile_skin_url(profile: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (value, signature) = parse_profile(profile).textures?;
    // rust: unpack(&value, signature, &TEXTURE_URIS).skin
}

/// The textures of a Minecraft services `/minecraft/profile` answer: the
/// `ACTIVE` skin and cape (`MinecraftProfileResponse`). Unsigned, like the
/// local player's own textures, and only URLs under the allowed domains count.
pub fn services_profile_textures(profile: *serde_json::Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let active = |key: &str| {
    // rust: profile
    // rust: .get(key)?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .find(|t| t.get("state").and_then(|s| s.as_str()) == Some("ACTIVE"))
}
    // rust: let skin_entry = active("skins");
    // rust: let skin = skin_entry
    // rust: .and_then(|t| t.get("url"))
    // rust: .and_then(|u| u.as_str())
    // rust: .filter(|url| {
    // rust: TEXTURE_URIS
    // rust: .iter()
    // rust: .any(|u| url.starts_with(&u.replace("{textureId}", "")))
    // rust: })
    // rust: .map(str::to_owned);
    // rust: let slim = skin_entry
    // rust: .and_then(|t| t.get("variant"))
    // rust: .and_then(|v| v.as_str())
    // rust: .is_some_and(|v| v.eq_ignore_ascii_case("slim"));
    // rust: let cape = active("capes")
    // rust: .and_then(|t| t.get("url"))
    // rust: .and_then(|u| u.as_str())
    // rust: .filter(|url| {
    // rust: TEXTURE_URIS
    // rust: .iter()
    // rust: .any(|u| url.starts_with(&u.replace("{textureId}", "")))
    // rust: })
    // rust: .map(str::to_owned);
    // rust: Textures {
    // rust: skin,
    // rust: slim,
    // rust: cape,
    // rust: elytra: None,
    // rust: signed: false,
}
}

/// `profile_skin_url` on a block entity's `profile` NBT (`SkullBlockEntity`):
/// the same `properties` list, held as a compound. A name-only profile (a
/// string tag) has no properties and no skin URL.
pub fn profile_skin_url_nbt(profile: *horizon_world::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let properties = match profile.get("properties")? {
    // rust: horizon_world::nbt::Tag::List(list) => list,
    // rust: _ => return None,
}
    // rust: let value = properties.iter().find_map(|p| {
    // rust: let name = nbt_text(p.get("name"))?;
    // rust: (name == "textures")
    // rust: .then(|| nbt_text(p.get("value")))
    // rust: .flatten()
    // rust: })?;
    // rust: unpack(&value, Signature::Unsigned, &TEXTURE_URIS).skin
}

/// `ResolvableProfile.skinPatch().body()` of a skull's `profile` NBT: the
/// `texture` id that replaces its skin.
pub fn profile_texture_nbt(profile: *horizon_world::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: nbt_text(profile.get("texture"))
}

/// The profile's uuid as u128: `id` as an int array (block entity NBT) or a
/// uuid string (older and component forms). Used for `DefaultPlayerSkin.get`
/// when a head's skin is not downloaded yet.
pub fn profile_uuid_nbt(profile: *horizon_world::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match profile.get("id")? {
    // rust: horizon_world::nbt::Tag::IntArray(v) if v.len() == 4 => Some(
    // rust: v.iter()
    // rust: .fold(0u128, |a, &w| (a << 32) | u128::from(w as u32)),
    // rust: ),
    // rust: horizon_world::nbt::Tag::String(s) => {
    // rust: let digits: String = s.to_string_lossy().chars().filter(|c| *c != '-').collect();
    // rust: u128::from_str_radix(&digits, 16).ok()
}
    // rust: _ => None,
}
}

    // rust: pub(crate) fn nbt_text(tag: Option<&horizon_world::nbt::Tag>) -> Option<String> {
    // rust: match tag {
    // rust: Some(horizon_world::nbt::Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}

    // rust: pub use crate::chunk::block_entity::NameOrId;

/// `GameProfile` as `fetchProfile` returns it: the account's id, name and
/// property map (its `textures` property is the skin).
pub const ResolvedProfile = struct {
    id: u128,
    name: []const u8,
    /// `(name, value, signature)` properties.
    properties: Vec<([]const u8,
};
    // rust: impl ResolvedProfile {
    /// `SessionService.getPackedTextures`: the `textures` property.
pub fn textures(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.properties
    // rust: .iter()
    // rust: .find(|(n, _, _)| n == "textures")
    // rust: .map(|(_, v, s)| {
    // rust: (
    // rust: v.clone(),
    // rust: if s.is_some() {
    // rust: Signature::Signed
    // rust: } else {
    // rust: Signature::Unsigned
    // rust: },
    // rust: )
    // rust: })
}
}

/// Where a `Dynamic` profile's resolution stands (`resolveProfile`'s future).
pub const Resolve = enum {
    Pending,
    /// The services' answer: `None` for no profile or no answer, which the
    /// cache holds like any result (`Optional.empty`).
    Done(Option<ResolvedProfile>),
};

/// `ProfileResolver.Cached`: resolves a `Dynamic` profile through the
/// services — `profileCacheByName` asks `profiles`/`getByName` for the id,
/// `profileCacheById` asks `session`/`getProfileById` for the profile —
/// at most 256 entries kept 10 minutes after their last use, fetched on
/// background threads.
pub const Resolver = struct {
    entries: std::collections::HashMap<NameOrId,
    done: std::sync::mpsc::Receiver<(NameOrId,
    send: std::sync::mpsc::Sender<(NameOrId,
    last_sweep: std::time::Instant,
};
pub const Entry = struct {
    touched: std::time::Instant,
    /// `None` while the fetch is in flight.
    resolved: ?Option<ResolvedProfile>,
};
/// `ProfileResolver.Cached`'s cache bounds.
pub const MAX_PROFILES: usize = 256;
pub const PROFILE_TTL: std::time::Duration = std::time::Duration::from_secs(10 * 60);

/// `StringUtil.isValidPlayerName` (the check `fetchByName` makes first).
pub fn valid_player_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.encode_utf16().count() <= 16 && name.encode_utf16().all(|c| c > 32 && c < 127)
}

/// `fetchByNameOrId`: `getByName` answers `{id, name}`; `getProfileById`
/// (`fetchProfile(id, requireSecure)`) answers `{id, name, properties}` —
/// asked `unsigned=false` so the `textures` property is signed.
pub fn resolve_profile(key: *NameOrId, doc: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = match key {
    // rust: NameOrId::Id(id) => *id,
    // rust: NameOrId::Name(name) => {
    // rust: let url = crate::auth::endpoint(doc, "profiles", "getByName")?
    // rust: .replace("{name}", &name.to_lowercase());
    // rust: let body = http_get(&url)?;
    // rust: let v: serde_json::Value = serde_json::from_slice(&body).ok()?;
    // rust: crate::auth::parse_uuid(v.get("id")?.as_str()?)?
}
}
    // rust: let url = crate::auth::endpoint(doc, "session", "getProfileById")?
    // rust: .replace("{profileId}", &format!("{id:032x}"));
    // rust: let separator = if url.contains('?') { '&' } else { '?' };
    // rust: let body = http_get(&format!("{url}{separator}unsigned=false"))?;
    // rust: let v: serde_json::Value = serde_json::from_slice(&body).ok()?;
    // rust: Some(ResolvedProfile {
    // rust: id: crate::auth::parse_uuid(v.get("id")?.as_str()?)?,
    // rust: name: v.get("name")?.as_str()?.to_owned(),
    // rust: properties: v
    // rust: .get("properties")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|p| {
    // rust: Some((
    // rust: p.get("name")?.as_str()?.to_owned(),
    // rust: p.get("value")?.as_str()?.to_owned(),
    // rust: p.get("signature")
    // rust: .and_then(|s| s.as_str())
    // rust: .map(str::to_owned),
    // rust: ))
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?,
    // rust: })
}

    // rust: impl Default for Resolver {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new()
}
}
    // rust: impl Resolver {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (send, done) = std::sync::mpsc::channel();
    // rust: Self {
    // rust: entries: Default::default(),
    // rust: done,
    // rust: send,
    // rust: last_sweep: std::time::Instant::now(),
}
}
    /// `CacheBuilder.expireAfterAccess` with `maximumSize`.
pub fn sweep(self: *Self) void {
}
    // rust: if self.last_sweep.elapsed() < std::time::Duration::from_secs(30) {
    // rust: return;
}
    // rust: self.last_sweep = std::time::Instant::now();
    // rust: self.entries
    // rust: .retain(|_, e| e.touched.elapsed() < PROFILE_TTL);
    // rust: while self.entries.len() > MAX_PROFILES
    // rust: && let Some(oldest) = self
    // rust: .entries
    // rust: .iter()
    // rust: .min_by_key(|(_, e)| e.touched)
    // rust: .map(|(k, _)| k.clone())
    // rust: {
    // rust: self.entries.remove(&oldest);
}
}
    /// How the resolution of `key` stands, starting it the first time.
pub fn state(self: *Self, key: *NameOrId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while let Ok((key, resolved)) = self.done.try_recv() {
    // rust: self.entries.insert(
    // rust: key,
    // rust: Entry {
    // rust: touched: std::time::Instant::now(),
    // rust: resolved: Some(resolved),
    // rust: },
    // rust: );
}
    // rust: self.sweep();
    // rust: if let Some(entry) = self.entries.get_mut(key) {
    // rust: entry.touched = std::time::Instant::now();
    // rust: return match &entry.resolved {
    // rust: Some(resolved) => Resolve::Done(resolved.clone()),
    // rust: None => Resolve::Pending,
}
}
        // `fetchByName` refuses an invalid name without a fetch; like every
        // other empty answer that is the cached result.
    // rust: let resolved = matches!(key, NameOrId::Name(name) if !valid_player_name(name));
    // rust: self.entries.insert(
    // rust: key.clone(),
    // rust: Entry {
    // rust: touched: std::time::Instant::now(),
    // rust: resolved: resolved.then_some(None),
    // rust: },
    // rust: );
    // rust: if resolved {
    // rust: return Resolve::Done(None);
}
    // rust: let (key, send) = (key.clone(), self.send.clone());
    // rust: std::thread::spawn(move || {
    // rust: let resolved = crate::auth::discovery()
    // rust: .ok()
    // rust: .and_then(|doc| resolve_profile(&key, &doc));
    // rust: let _ = send.send((key, resolved));
    // rust: });
    // rust: Resolve::Pending
}
}

/// `ResolvableProfile` (an item's `minecraft:profile` component, a skull's
/// `profile` tag): the `textures` property it carries, the key a `Dynamic`
/// profile resolves by, and `partialProfile.id` — the fallback skin's key.
pub const ProfileInfo = struct {
    /// `GameProfile.id` (`DefaultPlayerSkin.get`).
    id: u128,
    /// The `textures` property's value and signature state, when present.
    textures: Option<([]const u8,
    /// `Dynamic` profiles resolve by name or id.
    dynamic: ?NameOrId,
};

/// A profile's `id`: `UUIDUtil.CODEC` (an int array of four, or a UUID
/// string).
pub fn profile_id(v: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: serde_json::Value::Array(a) => {
    // rust: let ints: Option<Vec<i64>> = a.iter().map(|x| x.as_i64()).collect();
    // rust: let i = ints?;
    // rust: (i.len() == 4).then(|| {
    // rust: ((i[0] as u32 as u128) << 96)
    // rust: | ((i[1] as u32 as u128) << 64)
    // rust: | ((i[2] as u32 as u128) << 32)
    // rust: | i[3] as u32 as u128
    // rust: })
}
    // rust: serde_json::Value::String(s) => crate::auth::parse_uuid(s),
    // rust: _ => None,
}
}

/// `ResolvableProfile`'s read of a `profile` value: a bare name is
/// `createUnresolved` (the `PLAYER_NAME` codec's alternative), a compound
/// `name` + `id` + `properties` (`Partial.MAP_CODEC` or a `GameProfile`).
pub fn parse_profile(v: *serde_json::Value) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let serde_json::Value::String(name) = v {
    // rust: return ProfileInfo {
    // rust: id: horizon_protocol::crypto::offline_uuid(name),
    // rust: textures: None,
    // rust: dynamic: valid_player_name(name).then(|| NameOrId::Name(name.clone())),
}
}
    // rust: let name = v.get("name").and_then(|n| n.as_str()).map(str::to_owned);
    // rust: let id = v.get("id").and_then(profile_id);
    // rust: let properties = v.get("properties").and_then(|p| p.as_array());
    // rust: let textures = properties
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .find(|p| p.get("name").and_then(|n| n.as_str()) == Some("textures"))
    // rust: .and_then(|p| {
    // rust: Some((
    // rust: p.get("value")?.as_str()?.to_owned(),
    // rust: if p.get("signature").is_some() {
    // rust: Signature::Signed
    // rust: } else {
    // rust: Signature::Unsigned
    // rust: },
    // rust: ))
    // rust: });
    // `ResolvableProfile.create`: a Partial is Dynamic with no properties
    // and exactly one of a name or an id.
    // rust: let dynamic =
    // rust: (properties.is_none_or(|p| p.is_empty()) && name.is_some() != id.is_some()).then(|| {
    // rust: name.as_deref().map_or_else(
    // rust: || NameOrId::Id(id.unwrap()),
    // rust: |n| NameOrId::Name(n.to_owned()),
    // rust: )
    // rust: });
    // rust: ProfileInfo {
        // `createPartialProfile`: the id, else the name's offline UUID, else nil.
    // rust: id: id
    // rust: .or_else(|| name.as_deref().map(horizon_protocol::crypto::offline_uuid))
    // rust: .unwrap_or(0),
    // rust: textures,
    // rust: dynamic,
}
}

/// `ResolvableProfile.create`'s `Dynamic` key from a skull's `profile` tag:
/// a bare name string is `createUnresolved`, and a compound without
/// properties and with exactly one of a name or an id is `Dynamic`.
pub fn dynamic_nbt(profile: *horizon_world::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let horizon_world::nbt::Tag::String(s) = profile {
    // rust: let name = s.to_string_lossy();
    // rust: return valid_player_name(&name).then_some(NameOrId::Name(name));
}
    // rust: if matches!(profile.get("properties"), Some(horizon_world::nbt::Tag::List(l)) if !l.is_empty())
    // rust: {
    // rust: return None;
}
    // rust: match (nbt_text(profile.get("name")), profile_uuid_nbt(profile)) {
    // rust: (Some(name), None) => Some(NameOrId::Name(name)),
    // rust: (None, Some(id)) => Some(NameOrId::Id(id)),
    // rust: _ => None,
}
}

/// `PlayerSkinRenderCache.getOrDefault` for a head: the resolved skin once
/// its texture is in the atlas (`atlas`), else `partialProfile`'s default.
    // rust: pub fn head_skin(
    // rust: profile: &serde_json::Value,
    // rust: resolver: &mut Resolver,
    // rust: downloads: &mut Downloader,
    // rust: atlas: impl Fn(&str) -> bool,
    // rust: ) -> String {
    // rust: if let Some(texture) = profile.get("texture").and_then(|t| t.as_str())
    // rust: && let Some(sprite) = patch_skin(texture, downloads, &atlas)
    // rust: {
    // rust: return sprite;
}
    // rust: let p = parse_profile(profile);
    // rust: let property = p.textures.or_else(|| {
    // rust: let key = p.dynamic.as_ref()?;
    // rust: match resolver.state(key) {
    // rust: Resolve::Done(Some(profile)) => profile.textures(),
    // rust: _ => None,
}
    // rust: });
    // rust: if let Some((value, signature)) = property
    // rust: && let Some(url) = unpack(&value, signature, &TEXTURE_URIS).skin
    // rust: && let Some(hash) = texture_hash(&url)
    // rust: {
    // rust: let location = skin_location(&hash);
    // rust: match downloads.state(Kind::Skin, &url) {
    // rust: Download::Ready if atlas(&location) => {
    // rust: downloads.drawn(&location);
    // rust: return location;
}
            // Its slot was evicted: offer the image again.
    // rust: Download::Ready => {
    // rust: downloads.again(&location);
}
    // rust: _ => {}
}
}
    // rust: crate::tab_list::default_skin(p.id).to_owned()
}

/// `PlayerSkin.Patch.apply` for a head: the sprite of a profile's `texture`
/// override (`ClientAsset.ResourceTexture`, a resource pack's
/// `<namespace>:textures/<path>.png`), which replaces the downloaded or
/// default skin. Vanilla textures are in the atlas already; another
/// namespace's loads into a skin slot, and `None` answers until it is there
/// (or when the packs lack it).
    // rust: pub fn patch_skin(
    // rust: texture: &str,
    // rust: downloads: &mut Downloader,
    // rust: atlas: impl Fn(&str) -> bool,
    // rust: ) -> Option<String> {
    // rust: let (namespace, path) = texture.split_once(':').unwrap_or(("minecraft", texture));
    // rust: if !valid_texture_id(namespace, path) {
    // rust: return None;
}
    // rust: if namespace == "minecraft" && atlas(path) {
    // rust: return Some(path.to_owned());
}
    // rust: let location = format!("patch/{namespace}/{path}");
    // rust: if atlas(&location) {
    // rust: downloads.drawn(&location);
    // rust: return Some(location);
}
    // rust: downloads.resource(&location, namespace, path);
    // rust: None
}

/// `Identifier`'s characters (`isValidNamespace`, `isValidPath`), and no
/// `.`, `..` or empty segment (`FileUtil.decomposePath`, as the packs read
/// it): a server's `texture` never names a file outside the packs.
pub fn valid_texture_id(namespace: []const u8, path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let segment = |s: &str| !s.is_empty() && s != "." && s != "..";
    // rust: !namespace.is_empty()
    // rust: && namespace
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.'))
    // rust: && path
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.' | '/'))
    // rust: && segment(namespace)
    // rust: && path.split('/').all(segment)
}

/// A `width`x`height` RGBA image as the 64x64 skin it maps onto: each texel
/// the nearest of the image's at the same normalised UV.
pub fn resample_64(width: u32, height: u32, rgba: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (width as usize, height as usize);
    // rust: if w == 0 || h == 0 || rgba.len() < w * h * 4 {
    // rust: return None;
}
    // rust: let mut out = vec![0u8; 64 * 64 * 4];
    // rust: for y in 0..64 {
    // rust: for x in 0..64 {
    // rust: let (sx, sy) = (x * w / 64, y * h / 64);
    // rust: let s = (sy * w + sx) * 4;
    // rust: let d = (y * 64 + x) * 4;
    // rust: out[d..d + 4].copy_from_slice(&rgba[s..s + 4]);
}
}
    // rust: Some(out)
}

/// `MinecraftProfileTexture.getHash`: the base name of the URL's path.
pub fn texture_hash(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = url.split_once("://")?.1;
    // rust: let path = &rest[rest.find('/').unwrap_or(rest.len())..];
    // rust: let path = &path[..path.find(['?', '#']).unwrap_or(path.len())];
    // rust: let name = &path[path.rfind(['/', '\\']).map_or(0, |i| i + 1)..];
    // rust: Some(name[..name.rfind('.').unwrap_or(name.len())].to_owned())
}

/// `SkinManager.TextureCache.registerTexture`: the texture id of a skin,
/// `skins/` and the SHA-1 of its hash's UTF-16 code units.
pub fn skin_location(hash: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: location("skins/", hash)
}
/// `registerTexture` in the cape cache: `capes/` and the same SHA-1.
pub fn cape_location(hash: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: location("capes/", hash)
}
pub fn location(prefix: []const u8, hash: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let units: Vec<u8> = hash.encode_utf16().flat_map(u16::to_le_bytes).collect();
    // rust: let digest = sha1(&units);
    // rust: let mut out = String::from(prefix);
    // rust: for b in digest {
    // rust: out.push_str(&format!("{b:02x}"));
}
    // rust: out
}

/// `PlayerSkin.cape`: the cape texture of textures whose lookup gave a skin
/// (every download ready), if they name one.
pub fn cape(textures: *Textures) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: textures
    // rust: .cape
    // rust: .as_deref()
    // rust: .and_then(texture_hash)
    // rust: .map(|hash| cape_location(&hash))
}

/// A cape in a 64x64 skin slot: the 64x32 picture (or the older 22x17,
/// which has the same layout) in its top half. Vanilla draws a cape of any
/// size; a larger one is scaled down to 64x32 here.
pub fn process_cape(width: u32, height: u32, rgba: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (width as usize, height as usize);
    // rust: if w == 0 || h == 0 || rgba.len() < w * h * 4 {
    // rust: return None;
}
    // rust: let mut img = vec![0u8; 64 * 64 * 4];
    // rust: let (fit_w, fit_h) = if w <= 64 && h <= 32 { (w, h) } else { (64, 32) };
    // rust: for y in 0..fit_h {
    // rust: for x in 0..fit_w {
    // rust: let (sx, sy) = (x * w / fit_w, y * h / fit_h);
    // rust: let (s, d) = ((sy * w + sx) * 4, (y * 64 + x) * 4);
    // rust: img[d..d + 4].copy_from_slice(&rgba[s..s + 4]);
}
}
    // rust: Some(img)
}

/// The cape the launcher gives an offline name (`HORIZON_OFFLINE_CAPE`, a
/// PNG's path; launcher/src/skins.rs), read once as `process_cape` lays it out.
pub fn offline_cape() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const CAPE: std::sync::OnceLock<?std.ArrayList(u8)> = std::sync::OnceLock::new();
    // rust: CAPE.get_or_init(|| {
    // rust: let path = std::env::var_os("HORIZON_OFFLINE_CAPE").filter(|p| !p.is_empty())?;
    // rust: let image = std::fs::read(&path)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|bytes| crate::hud::decode_bytes(&bytes).map_err(|e| e.to_string()))
    // rust: .and_then(|(w, h, rgba)| process_cape(w, h, &rgba).ok_or("not an image".into()));
    // rust: image
    // rust: .inspect_err(|e| eprintln!("Horizon: no offline cape ({}): {e}", path.display()))
    // rust: .ok()
    // rust: })
    // rust: .as_deref()
}

/// The skin the launcher gives an offline name (`HORIZON_OFFLINE_SKIN`, a
/// PNG's path, and `HORIZON_OFFLINE_SKIN_MODEL`, `classic` or `slim`;
/// launcher/src/skins.rs): its 64x64 RGBA as `process_legacy_skin` lays it
/// out, and whether it is slim. Read once.
pub fn offline_skin() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const SKIN: std::sync::OnceLock<?(std.ArrayList(u8), bool)> = std::sync::OnceLock::new();
    // rust: SKIN.get_or_init(|| {
    // rust: let path = std::env::var_os("HORIZON_OFFLINE_SKIN").filter(|p| !p.is_empty())?;
    // rust: let model = std::env::var("HORIZON_OFFLINE_SKIN_MODEL").unwrap_or_default();
    // rust: read_offline_skin(std::path::Path::new(&path), &model)
    // rust: .inspect_err(|e| eprintln!("Horizon: no offline skin ({}): {e}", path.display()))
    // rust: .ok()
    // rust: })
    // rust: .as_ref()
}
pub fn read_offline_skin(path: *std::path::Path, model: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = std::fs::read(path).map_err(|e| e.to_string())?;
    // rust: let (w, h, rgba) = crate::hud::decode_bytes(&bytes).map_err(|e| e.to_string())?;
    // rust: let skin = process_legacy_skin(w, h, &rgba).ok_or("not a 64x64 or 64x32 skin")?;
    // rust: Ok((skin, model == "slim"))
}

/// The signed-in account's own profile properties (`Minecraft.profileFuture`:
/// `fetchProfile(id, true)`, so its `textures` property is signed), or empty
/// without an answer. Blocks on the network.
pub fn fetch_own_properties(id: u128) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::auth::discovery()
    // rust: .ok()
    // rust: .and_then(|doc| resolve_profile(&NameOrId::Id(id), &doc))
    // rust: .map(|p| p.properties)
    // rust: .unwrap_or_default()
}

/// Where a texture download stands.
pub const Download = enum {
    Ready,
    Pending,
    Failed,
};

/// `MinecraftProfileTexture.Type`: which texture cache a download is in.
pub const Kind = enum {
    Skin,
    Cape,
    Elytra,
};

/// `SkinManager.createLookup(profile, requireSecure).get()`: the skin
/// texture a player shows, or `None` for their default skin. `download`
/// tells how the skin, cape and elytra texture downloads stand.
    // rust: pub fn lookup(
    // rust: textures: &Textures,
    // rust: require_secure: bool,
    // rust: mut download: impl FnMut(Kind, &str) -> Download,
    // rust: ) -> Option<String> {
    // rust: let mut skin = None;
    // rust: let mut state = Download::Ready;
    // rust: let urls = [
    // rust: (Kind::Skin, &textures.skin),
    // rust: (Kind::Cape, &textures.cape),
    // rust: (Kind::Elytra, &textures.elytra),
    // rust: ];
    // rust: for (kind, url) in urls {
    // rust: let Some(url) = url else { continue };
        // registerTexture computes the hash first: a bad URL, even a cape's,
        // fails the whole lookup.
    // rust: let hash = texture_hash(url)?;
    // rust: if kind == Kind::Skin {
    // rust: skin = Some(skin_location(&hash));
}
    // rust: match download(kind, url) {
            // `SkinManager.registerTextures` joins the skin, cape and elytra
            // futures with `allOf`: any one failing fails the profile's
            // `PlayerSkin`, and `createLookup` then shows the default skin.
    // rust: Download::Failed => return None,
    // rust: Download::Pending => state = Download::Pending,
    // rust: Download::Ready => {}
}
}
    // rust: if state != Download::Ready || require_secure && !textures.signed {
    // rust: return None;
}
    // rust: skin
}

/// `SkinTextureDownloader.processLegacySkin` on RGBA pixels: 64x32 skins
/// get the 64x64 layout, and the opaque parts lose their alpha. `None` for
/// any other size (the download fails).
pub fn process_legacy_skin(width: u32, height: u32, rgba: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width != 64 || height != 32 && height != 64 {
    // rust: return None;
}
    // rust: let legacy = height == 32;
    // rust: let mut img = vec![0u8; 64 * 64 * 4];
    // rust: let n = rgba.len().min(img.len());
    // rust: img[..n].copy_from_slice(&rgba[..n]);
    // rust: let at = |x: i32, y: i32| ((y * 64 + x) * 4) as usize;
    // rust: if legacy {
    // rust: let rects = [
    // rust: (4, 16, 16, 32, 4, 4),
    // rust: (8, 16, 16, 32, 4, 4),
    // rust: (0, 20, 24, 32, 4, 12),
    // rust: (4, 20, 16, 32, 4, 12),
    // rust: (8, 20, 8, 32, 4, 12),
    // rust: (12, 20, 16, 32, 4, 12),
    // rust: (44, 16, -8, 32, 4, 4),
    // rust: (48, 16, -8, 32, 4, 4),
    // rust: (40, 20, 0, 32, 4, 12),
    // rust: (44, 20, -8, 32, 4, 12),
    // rust: (48, 20, -16, 32, 4, 12),
    // rust: (52, 20, -8, 32, 4, 12),
    // rust: ];
    // rust: for (sx, sy, ox, oy, w, h) in rects {
    // rust: for y in 0..h {
    // rust: for x in 0..w {
    // rust: let (s, d) = (at(sx + x, sy + y), at(sx + ox + w - 1 - x, sy + oy + y));
    // rust: let p: [u8; 4] = img[s..s + 4].try_into().unwrap();
    // rust: img[d..d + 4].copy_from_slice(&p);
}
}
}
}
    // rust: let no_alpha = |img: &mut Vec<u8>, x0: i32, y0: i32, x1: i32, y1: i32| {
    // rust: for x in x0..x1 {
    // rust: for y in y0..y1 {
    // rust: img[at(x, y) + 3] = 255;
}
}
}
    // rust: no_alpha(&mut img, 0, 0, 32, 16);
    // rust: if legacy {
        // doNotchTransparencyHack: a fully opaque hat layer is cleared.
    // rust: let opaque = (32..64).all(|x| (0..32).all(|y| img[at(x, y) + 3] >= 128));
    // rust: if opaque {
    // rust: for x in 32..64 {
    // rust: for y in 0..32 {
    // rust: img[at(x, y) + 3] = 0;
}
}
}
}
    // rust: no_alpha(&mut img, 0, 16, 64, 32);
    // rust: no_alpha(&mut img, 16, 48, 48, 64);
    // rust: Some(img)
}

/// `SkinTextureDownloader`: fetches textures on background threads, from
/// the local cache (`<root>/<2 hex>/<sha1>`) or over HTTP, keeping each one
/// by kind and hash as vanilla's `TextureCache`s do. A texture that can't
/// be fetched fails, and the player keeps their default skin.
pub const Downloader = struct {
    root: std::path::PathBuf,
    states: std::collections::HashMap<(Kind,
    done: std::sync::mpsc::Receiver<((Kind,
    send: std::sync::mpsc::Sender<((Kind,
    ready: Vec<([]const u8,
    /// Locations already in `ready`, so `again` does not double-queue.
    queued: std::collections::std.AutoHashMap([]const u8, void),
    /// Decoded skin images by location, kept so a skin evicted from the
    /// atlas uploads again (`again`); the disk cache backs anything dropped.
    images: std::collections::HashMap<[]const u8,
    image_order: std::collections::VecDeque<[]const u8>,
    /// Skins and capes drawn from the atlas since `take_drawn`.
    drawn: std::collections::std.AutoHashMap([]const u8, void),
    /// The resource packs' root, where a profile's `texture` patch is read.
    resource_root: std::path::PathBuf,
    /// How each `patch/` texture of the resource packs loaded, by location.
    resources: std::collections::HashMap<[]const u8,
    /// When each failed texture download was last tried, so it can be retried:
    /// a transient network error must not pin a player to the default skin for
    /// the rest of the session.
    failed: std::collections::HashMap<(Kind,
    /// How long a failed texture download waits before it is tried again.
    retry_after: std::time::Duration,
};
/// `images` is bounded only so a long session on a busy server does not grow
/// without end; the disk cache holds everything it drops.
pub const MAX_SKIN_IMAGES: usize = 1024;
    // rust: impl Downloader {
    /// The decoded 64×64 RGBA image an atlas location holds, when it is
    /// still in memory (3D skin layers builds its geometry from it, and the
    /// disk cache backs whatever was dropped).
pub fn image(self: *Self, location: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.images.get(location).map(Vec::as_slice)
}
    /// Keeps a decoded image under `location` for the images read back later
    /// (a launcher's offline skin, which skips `queue`).
pub fn remember_image(self: *Self, location: []const u8, rgba: []const u8) void {
}
    // rust: self.remember(location.to_owned(), rgba.to_vec());
}
pub fn new(root: std::path::PathBuf) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (send, done) = std::sync::mpsc::channel();
    // rust: Self {
    // rust: root,
    // rust: states: Default::default(),
    // rust: done,
    // rust: send,
    // rust: ready: Vec::new(),
    // rust: queued: Default::default(),
    // rust: images: Default::default(),
    // rust: image_order: Default::default(),
    // rust: drawn: Default::default(),
    // rust: resource_root: Default::default(),
    // rust: resources: Default::default(),
    // rust: failed: Default::default(),
    // rust: retry_after: std::time::Duration::from_secs(60),
}
}
    /// The resource packs changed (or were first loaded) at `root`: patch
    /// textures load again from there.
pub fn set_resource_root(self: *Self, root: std::path::PathBuf) void {
}
    // rust: for location in std::mem::take(&mut self.resources).into_keys() {
    // rust: self.images.remove(&location);
    // rust: self.image_order.retain(|l| *l != location);
}
    // rust: self.resource_root = root;
}
    /// `ClientAsset.ResourceTexture`: loads `<namespace>:textures/<path>.png`
    /// from the resource packs into a skin slot as `location`, once. A
    /// texture of another size is sampled as the model's normalised UVs would
    /// sample it (nearest texel) into the 64x64 slot.
pub fn resource(self: *Self, location: []const u8, namespace: []const u8, path: []const u8) void {
}
    // rust: match self.resources.get(location) {
    // rust: Some(Download::Failed) => return,
    // rust: Some(_) => {
    // rust: self.again(location);
    // rust: return;
}
    // rust: None => {}
}
    // rust: let file = self
    // rust: .resource_root
    // rust: .join(format!("assets/{namespace}/textures/{path}.png"));
    // rust: let image = std::fs::read(file)
    // rust: .ok()
    // rust: .and_then(|b| crate::hud::decode_bytes(&b).ok())
    // rust: .and_then(|(w, h, rgba)| resample_64(w, h, &rgba));
    // rust: let state = match image {
    // rust: Some(rgba) => {
    // rust: self.queue(location.to_owned(), rgba);
    // rust: Download::Ready
}
    // rust: None => Download::Failed,
}
    // rust: self.resources.insert(location.to_owned(), state);
}
    /// How the download of `url` stands, starting it the first time. A
    /// failure is permanent for `retry_after`, then tried again.
pub fn state(self: *Self, kind: Kind, url: []const u8) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while let Ok((key, image)) = self.done.try_recv() {
    // rust: let state = match image {
    // rust: Some(rgba) => {
    // rust: match key.0 {
    // rust: Kind::Skin => self.queue(skin_location(&key.1), rgba),
    // rust: Kind::Cape => self.queue(cape_location(&key.1), rgba),
    // rust: Kind::Elytra => {}
}
    // rust: self.failed.remove(&key);
    // rust: Download::Ready
}
    // rust: None => {
    // rust: self.failed.insert(key.clone(), std::time::Instant::now());
    // rust: Download::Failed
}
}
    // rust: self.states.insert(key, state);
}
    // rust: let Some(hash) = texture_hash(url) else {
    // rust: return Download::Failed;
}
    // rust: let key = (kind, hash);
    // rust: if let Some(state) = self.states.get(&key).copied() {
    // rust: let due = self
    // rust: .failed
    // rust: .get(&key)
    // rust: .is_none_or(|at| at.elapsed() >= self.retry_after);
    // rust: if state != Download::Failed || !due {
    // rust: return state;
}
    // rust: self.states.remove(&key);
    // rust: self.failed.remove(&key);
}
    // rust: self.states.insert(key.clone(), Download::Pending);
    // rust: let digest: String = skin_location(&key.1)["skins/".len()..].to_owned();
    // rust: let (url, send, root) = (url.to_owned(), self.send.clone(), self.root.clone());
    // rust: std::thread::spawn(move || {
    // rust: let image = Self::load_texture(&root, kind, &digest, &url, http_get);
    // rust: let _ = send.send((key, image));
    // rust: });
    // rust: Download::Pending
}
    /// One texture's pixels: the disk cache's body if it decodes, else a fetch
    /// (`SkinTextureDownloader.downloadSkin`). Only a body that decodes is
    /// written to the cache: an error page or a half image must not be what a
    /// later start reads instead of fetching again.
    // rust: fn load_texture(
    // rust: root: &std::path::Path,
    // rust: kind: Kind,
    // rust: digest: &str,
    // rust: url: &str,
    // rust: fetch: impl FnOnce(&str) -> Option<Vec<u8>>,
    // rust: ) -> Option<Vec<u8>> {
    // rust: let file = root
    // rust: .join(if digest.len() > 2 { &digest[..2] } else { "xx" })
    // rust: .join(digest);
    // rust: let decode = |bytes: &[u8]| -> Option<Vec<u8>> {
    // rust: let (w, h, rgba) = crate::hud::decode_bytes(bytes).ok()?;
    // rust: match kind {
    // rust: Kind::Skin => process_legacy_skin(w, h, &rgba),
    // rust: Kind::Cape => process_cape(w, h, &rgba),
    // rust: Kind::Elytra => Some(rgba),
}
}
    // rust: if let Some(image) = std::fs::read(&file).ok().and_then(|b| decode(&b)) {
    // rust: return Some(image);
}
    // rust: let body = fetch(url)?;
    // rust: let image = decode(&body)?;
    // rust: let _ = std::fs::create_dir_all(file.parent()?);
    // rust: let _ = std::fs::write(&file, &body);
    // rust: Some(image)
}
    /// Keeps a decoded skin for `again`, dropping the oldest past the bound.
pub fn remember(self: *Self, location: []const u8, rgba: std.ArrayList(u8)) void {
}
    // rust: if !self.images.contains_key(&location) {
    // rust: self.image_order.push_back(location.clone());
    // rust: while self.image_order.len() > MAX_SKIN_IMAGES
    // rust: && let Some(old) = self.image_order.pop_front()
    // rust: {
    // rust: self.images.remove(&old);
}
}
    // rust: self.images.insert(location, rgba);
}
    /// An image off to the atlas: remembered for `again` and marked queued
    /// so nothing uploads the same location twice.
pub fn queue(self: *Self, location: []const u8, rgba: std.ArrayList(u8)) void {
}
    // rust: self.remember(location.clone(), rgba.clone());
    // rust: self.queued.insert(location.clone());
    // rust: self.ready.push((location, rgba));
}
    /// A ready skin whose atlas slot was evicted (`show_skin` answered no):
    /// its image for upload again, from memory or the disk cache.
pub fn again(self: *Self, location: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.queued.contains(location) {
    // rust: return true;
}
    // rust: if location.starts_with("patch/") {
    // rust: let Some(image) = self.images.get(location).cloned() else {
                // Dropped from memory: read from the packs again.
    // rust: self.resources.remove(location);
    // rust: return false;
}
    // rust: self.queue(location.to_owned(), image);
    // rust: return true;
}
    // rust: let (digest, process): (_, fn(u32, u32, &[u8]) -> Option<Vec<u8>>) =
    // rust: if let Some(digest) = location.strip_prefix("skins/") {
    // rust: (digest, process_legacy_skin)
    // rust: } else if let Some(digest) = location.strip_prefix("capes/") {
    // rust: (digest, process_cape)
    // rust: } else {
    // rust: return false;
}
    // rust: let image = self.images.get(location).cloned().or_else(|| {
    // rust: let file = self
    // rust: .root
    // rust: .join(if digest.len() > 2 { &digest[..2] } else { "xx" })
    // rust: .join(digest);
    // rust: let (w, h, rgba) = crate::hud::decode_bytes(&std::fs::read(&file).ok()?).ok()?;
    // rust: process(w, h, &rgba)
    // rust: });
    // rust: let Some(image) = image else {
    // rust: return false;
}
    // rust: self.queue(location.to_owned(), image);
    // rust: true
}
    /// Skins that finished since the last call: texture id and 64x64 RGBA.
pub fn take_ready(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for (location, _) in &self.ready {
    // rust: self.queued.remove(location);
}
    // rust: std::mem::take(&mut self.ready)
}
    /// A skin or cape in the atlas drawn this frame: `SkinSlots` keeps its slot.
pub fn drawn(self: *Self, location: []const u8) void {
}
    // rust: if !self.drawn.contains(location) {
    // rust: self.drawn.insert(location.to_owned());
}
}
    /// The skins and capes drawn since the last call.
pub fn take_drawn(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.drawn)
}
}

/// Which downloaded skins and capes hold the atlas's skin slots
/// (`hud::SKIN_SLOTS`). Vanilla's `SkinManager.TextureCache.getOrLoad`
/// registers a texture per skin and keeps it. Here the slots are shared: a
/// new skin takes a free slot, else the least recently drawn skin's, but
/// never one drawn in the last frame. With every slot drawn, the new skin
/// waits (its player keeps the default skin) instead of pushing out one in
/// use, which then came back by pushing out another, so players vanished
/// for a frame and heads swapped textures as the slots went round.
pub const SkinSlots = struct {
    capacity: usize,
    /// Stored locations and their slot, the least recently drawn first.
    slots: Vec<([]const u8,
    /// Drawn in the last frame, or stored since: kept from eviction.
    kept: std::collections::std.AutoHashMap([]const u8, void),
};
    // rust: impl SkinSlots {
pub fn new(capacity: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: capacity,
    // rust: slots: Vec::new(),
    // rust: kept: Default::default(),
}
}
    /// The atlas was replaced (a resource pack reload): every slot is blank,
    /// so no skin counts as stored and each uploads again.
pub fn forget(self: *Self) void {
}
    // rust: self.slots.clear();
    // rust: self.kept.clear();
}
    /// Whether `location` is in a slot.
pub fn contains(self: *Self, location: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slots.iter().any(|(l, _)| l == location)
}
    /// A new frame: the skins `drawn` in the last one
    /// (`Downloader::take_drawn`) become the most recently drawn, and keep
    /// their slots through this frame's `place`s.
pub fn next_frame(self: *Self, drawn: std::collections::std.AutoHashMap([]const u8, void)) void {
}
    // rust: let (recent, old): (Vec<_>, Vec<_>) = std::mem::take(&mut self.slots)
    // rust: .into_iter()
    // rust: .partition(|(l, _)| drawn.contains(l));
    // rust: self.slots = old;
    // rust: self.slots.extend(recent);
    // rust: self.kept = drawn;
}
    /// A slot for `location`: its own, a free one, else the least recently
    /// drawn one not kept, with the location it held. `None` while every
    /// slot is kept.
pub fn place(self: *Self, location: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some((_, slot)) = self.slots.iter().find(|(l, _)| *l == location) {
    // rust: return Some((*slot, None));
}
    // rust: let (slot, evicted) = if self.slots.len() < self.capacity {
    // rust: (self.slots.len(), None)
    // rust: } else {
    // rust: let i = self
    // rust: .slots
    // rust: .iter()
    // rust: .position(|(l, _)| !self.kept.contains(l))?;
    // rust: let (old, slot) = self.slots.remove(i);
    // rust: (slot, Some(old))
}
    // rust: self.kept.insert(location.clone());
    // rust: self.slots.push((location, slot));
    // rust: Some((slot, evicted))
}
}

/// A GET over HTTP or HTTPS (textures.minecraft.net serves both; vanilla
/// uses https): the body of a 2xx answer, 16 MiB at most, after redirects.
pub fn http_get(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::io::Read;
    // rust: let response = ureq::AgentBuilder::new()
    // rust: .timeout(std::time::Duration::from_secs(15))
    // rust: .user_agent("Java")
    // rust: .build()
    // rust: .get(url)
    // rust: .call()
    // rust: .ok()?;
    // rust: let mut body = Vec::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(16 << 20)
    // rust: .read_to_end(&mut body)
    // rust: .ok()?;
    // rust: Some(body)
}

/// SHA-1 (FIPS 180-4).
pub fn sha1(data: []const u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
//     use sha1::{Digest, Sha1};
    // rust: Sha1::digest(data).into()
}

    // rust: mod tests {
    /// A profile's `texture` names a pack texture, never a file outside the
    /// packs: bad characters and `..` segments draw nothing.
pub fn a_texture_patch_stays_inside_the_packs() void {
}
//         use super::valid_texture_id;
    // rust: assert!(valid_texture_id("ethereal", "entity/plush_blank"));
    // rust: assert!(valid_texture_id("minecraft", "entity/player/wide/steve"));
    // rust: assert!(!valid_texture_id("ethereal", "../../../secret"));
    // rust: assert!(!valid_texture_id("..", "entity/x"));
    // rust: assert!(!valid_texture_id("ethereal", "entity//x"));
    // rust: assert!(!valid_texture_id("Ethereal", "entity/x"));
    // rust: assert!(!valid_texture_id("ethereal", "entity\\x"));
    // rust: assert!(!valid_texture_id("", "entity/x"));
}

    /// A pack reload swaps the atlas: its skin slots are blank, so a forgotten
    /// table holds nothing and hands out slots from the start again, even for
    /// skins drawn in the last frame.
pub fn a_new_atlas_forgets_every_skin_slot() void {
}
//         use super::SkinSlots;
    // rust: let mut slots = SkinSlots::new(2);
    // rust: assert_eq!(slots.place("skins/a".into()), Some((0, None)));
    // rust: assert_eq!(slots.place("skins/b".into()), Some((1, None)));
    // rust: assert_eq!(slots.place("skins/c".into()), None);
    // rust: slots.forget();
    // rust: assert!(!slots.contains("skins/a"));
    // rust: assert!(!slots.contains("skins/b"));
    // rust: assert_eq!(slots.place("skins/c".into()), Some((0, None)));
    // rust: assert_eq!(slots.place("skins/a".into()), Some((1, None)));
}

    /// The launcher's offline skin: a 64x64 or legacy 64x32 PNG laid out as
    /// a downloaded skin, slim only for the `slim` model; anything else is
    /// refused and the player keeps their default skin.
pub fn offline_skins_read_like_downloaded_ones() void {
}
    // rust: let png = |w: u32, h: u32| {
    // rust: let rgba: Vec<u8> = (0..w * h * 4).map(|i| (i % 251) as u8).collect();
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&rgba)
    // rust: .unwrap();
    // rust: (out, rgba)
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-offline-skin-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let file = dir.join("steve.png");
    // rust: for (h, model, slim) in [(64, "slim", true), (32, "classic", false), (64, "", false)] {
    // rust: let (bytes, rgba) = png(64, h);
    // rust: std::fs::write(&file, bytes).unwrap();
    // rust: let (skin, is_slim) = super::read_offline_skin(&file, model).unwrap();
    // rust: assert_eq!(skin, super::process_legacy_skin(64, h, &rgba).unwrap());
    // rust: assert_eq!(skin.len(), 64 * 64 * 4);
    // rust: assert_eq!(is_slim, slim);
}
    // rust: std::fs::write(&file, png(32, 32).0).unwrap();
    // rust: assert!(super::read_offline_skin(&file, "slim").is_err());
    // rust: std::fs::write(&file, b"not a png").unwrap();
    // rust: assert!(super::read_offline_skin(&file, "slim").is_err());
    // rust: assert!(super::read_offline_skin(&dir.join("missing.png"), "").is_err());
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

    /// `MinecraftProfileTexture.getMetadata("model")`: `slim` marks a slim
    /// skin; no metadata is the wide (classic) model.
pub fn a_skins_model_comes_from_its_metadata() void {
}
//         use super::{Signature, TEXTURE_URIS, unpack};
    // rust: let slim = "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHBzOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2FiYyIsIm1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9fX19";
    // rust: let wide = "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHBzOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2FiYyJ9fX0=";
    // rust: let t = unpack(slim, Signature::Signed, &TEXTURE_URIS);
    // rust: assert_eq!(
    // rust: t.skin.as_deref(),
    // rust: Some("https://textures.minecraft.net/texture/abc")
    // rust: );
    // rust: assert!(t.slim);
    // rust: assert!(!unpack(wide, Signature::Signed, &TEXTURE_URIS).slim);
}
pub fn profiles_parse_like_resolvable_profiles() void {
}
//         use super::{NameOrId, Signature, parse_profile};
        // A bare name is `createUnresolved`: dynamic by name, and its partial
        // id is the name's offline UUID.
    // rust: let p = parse_profile(&serde_json::json!("Notch"));
    // rust: assert_eq!(p.dynamic, Some(NameOrId::Name("Notch".into())));
    // rust: assert_eq!(p.id, horizon_protocol::crypto::offline_uuid("Notch"));
    // rust: assert!(p.textures.is_none());
        // A name-only compound resolves the same way.
    // rust: let p = parse_profile(&serde_json::json!({"name": "Notch"}));
    // rust: assert_eq!(p.dynamic, Some(NameOrId::Name("Notch".into())));
        // An id-only compound resolves by id (int array or UUID string).
    // rust: let id = 0x0123_4567_89ab_cdef_0123_4567_89ab_cdef_u128;
    // rust: let ints: Vec<i64> = [
    // rust: (id >> 96) as i32 as i64,
    // rust: (id >> 64) as i32 as i64,
    // rust: (id >> 32) as i32 as i64,
    // rust: id as i32 as i64,
    // rust: ]
    // rust: .into();
    // rust: let p = parse_profile(&serde_json::json!({"id": ints}));
    // rust: assert_eq!(p.dynamic, Some(NameOrId::Id(id)));
    // rust: let p = parse_profile(&serde_json::json!({"id": "01234567-89ab-cdef-0123-4567abcdef00"}));
    // rust: assert_eq!(
    // rust: p.dynamic,
    // rust: Some(NameOrId::Id(0x0123_4567_89ab_cdef_0123_4567_abcd_ef00))
    // rust: );
        // Name and id but no properties is Static: it never resolves, and its
        // default skin keys off the id.
    // rust: let p = parse_profile(&serde_json::json!({"name": "Notch", "id": ints}));
    // rust: assert!(p.dynamic.is_none());
    // rust: assert_eq!(p.id, id);
        // A `textures` property makes it Static (unsigned and signed).
    // rust: let p = parse_profile(&serde_json::json!({
    // rust: "properties": [{"name": "textures", "value": "v"}]
    // rust: }));
    // rust: assert!(p.dynamic.is_none());
    // rust: assert_eq!(p.textures, Some(("v".into(), Signature::Unsigned)));
    // rust: let p = parse_profile(&serde_json::json!({
    // rust: "properties": [{"name": "textures", "value": "v", "signature": "s"}]
    // rust: }));
    // rust: assert_eq!(p.textures, Some(("v".into(), Signature::Signed)));
        // Empty properties leave it dynamic.
    // rust: let p = parse_profile(&serde_json::json!({"name": "Notch", "properties": []}));
    // rust: assert_eq!(p.dynamic, Some(NameOrId::Name("Notch".into())));
}

pub fn services_profile_answers_give_the_active_skin_and_cape() void {
}
    // rust: let profile = serde_json::json!({
    // rust: "skins": [
    // rust: {"state": "INACTIVE", "url": "https://textures.minecraft.net/texture/old"},
    // rust: {"state": "ACTIVE", "url": "https://textures.minecraft.net/texture/skin1", "variant": "CLASSIC"}
    // rust: ],
    // rust: "capes": [{"state": "ACTIVE", "url": "http://textures.minecraft.net/texture/cape1"}]
    // rust: });
    // rust: let t = super::services_profile_textures(&profile);
    // rust: assert_eq!(
    // rust: t.skin.as_deref(),
    // rust: Some("https://textures.minecraft.net/texture/skin1")
    // rust: );
    // rust: assert_eq!(
    // rust: t.cape.as_deref(),
    // rust: Some("http://textures.minecraft.net/texture/cape1")
    // rust: );
    // rust: assert!(!t.signed);
    // rust: let elsewhere = serde_json::json!({"skins": [{"state": "ACTIVE", "url": "https://evil.example/texture/x"}]});
    // rust: assert_eq!(
    // rust: super::services_profile_textures(&elsewhere),
    // rust: super::Textures::default()
    // rust: );
    // rust: assert_eq!(
    // rust: super::services_profile_textures(&serde_json::json!({})),
    // rust: super::Textures::default()
    // rust: );
}

    /// `getByName` and `getProfileById` answer from the services the
    /// discovery document names; a profile resolves through both.
pub fn profiles_resolve_through_the_services() void {
}
//         use std::io::{BufRead, BufReader, Write};
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let base = format!("http://{}", listener.local_addr().unwrap());
    // rust: std::thread::spawn(move || {
    // rust: let reply = |status: &str, body: &str| {
    // rust: format!(
    // rust: "HTTP/1.1 {status}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
    // rust: body.len()
    // rust: )
}
    // rust: for stream in listener.incoming().take(3) {
    // rust: let mut stream = stream.unwrap();
    // rust: let mut line = String::new();
    // rust: let mut reader = BufReader::new(stream.try_clone().unwrap());
    // rust: reader.read_line(&mut line).unwrap();
    // rust: while reader.read_line(&mut String::new()).unwrap() > 2 {}
    // rust: let body = if line.contains("/users/profiles/minecraft/") {
    // rust: r#"{"id":"069a79f444e94726a5befca90e38aaf5","name":"Notch"}"#
    // rust: } else if line.contains("/session/minecraft/profile/")
    // rust: && line.contains("unsigned=false")
    // rust: {
    // rust: r#"{"id":"069a79f444e94726a5befca90e38aaf5","name":"Notch","properties":[{"name":"textures","value":"dmFsdWU=","signature":"c2ln"}]}"#
    // rust: } else {
    // rust: "{}"
}
    // rust: stream.write_all(reply("200 OK", body).as_bytes()).unwrap();
}
    // rust: });
    // rust: let doc = serde_json::json!({"discovery": {
    // rust: "profiles": {"endpoints": {"getByName": {"uri": format!("{base}/users/profiles/minecraft/{{name}}")}}},
    // rust: "session": {"endpoints": {"getProfileById": {"uri": format!("{base}/session/minecraft/profile/{{profileId}}")}}},
    // rust: }});
    // rust: let resolved =
    // rust: super::resolve_profile(&super::NameOrId::Name("Notch".into()), &doc).unwrap();
    // rust: assert_eq!(resolved.id, 0x069a_79f4_44e9_4726_a5be_fca9_0e38_aaf5);
    // rust: assert_eq!(resolved.name, "Notch");
    // rust: assert_eq!(
    // rust: resolved.properties,
    // rust: vec![(
    // rust: "textures".to_owned(),
    // rust: "dmFsdWU=".to_owned(),
    // rust: Some("c2ln".to_owned())
    // rust: )]
    // rust: );
    // rust: let by_id = super::resolve_profile(&super::NameOrId::Id(resolved.id), &doc).unwrap();
    // rust: assert_eq!(by_id.name, "Notch");
        // A discovery without `profiles`/`getByName` resolves no name.
    // rust: let doc = serde_json::json!({"discovery": {
    // rust: "session": {"endpoints": {"getProfileById": {"uri": format!("{base}/session/minecraft/profile/{{profileId}}")}}},
    // rust: }});
    // rust: assert!(super::resolve_profile(&super::NameOrId::Name("Notch".into()), &doc).is_none());
}

    /// More skins drawn every frame than there are slots (#3829): a frame's
    /// uploads used to push out skins drawn the frame before, which then
    /// uploaded again and pushed out others, so the drawn skins went missing
    /// in turn. Those drawn keep their slots; the rest wait.
pub fn skins_drawn_last_frame_keep_their_slots() void {
}
    // rust: let mut d = super::Downloader::new(std::env::temp_dir().join("horizon-test-skin-slots"));
    // rust: let skins: Vec<String> = (0..6).map(|i| format!("skins/{i}")).collect();
    // rust: for (i, s) in skins.iter().enumerate() {
    // rust: d.remember(s.clone(), vec![i as u8]);
}
    // rust: let mut slots = super::SkinSlots::new(4);
    // rust: let mut last: Option<Vec<String>> = None;
    // rust: for frame in 0..8 {
            // draw_tab_list: the downloads that finished go to the atlas.
    // rust: slots.next_frame(d.take_drawn());
    // rust: let mut uploads = 0;
    // rust: for (location, _) in d.take_ready() {
    // rust: if slots.place(location).is_some() {
    // rust: uploads += 1;
}
}
            // update_remote_skins: every skin is drawn, from its slot, or
            // asked for again while it has none.
    // rust: let mut shown = Vec::new();
    // rust: for s in &skins {
    // rust: if slots.contains(s) {
    // rust: d.drawn(s);
    // rust: shown.push(s.clone());
    // rust: } else {
    // rust: d.again(s);
}
}
    // rust: if frame >= 2 {
    // rust: assert_eq!(uploads, 0, "frame {frame} uploaded again");
    // rust: assert_eq!(Some(&shown), last.as_ref(), "frame {frame} lost a skin");
}
            // The first frame asks for the skins; from the next, four show.
    // rust: assert_eq!(shown.len(), if frame == 0 { 0 } else { 4 });
    // rust: last = Some(shown);
}
        // A skin no longer drawn gives up its slot to a waiting one.
    // rust: let mut slots = super::SkinSlots::new(2);
    // rust: slots.next_frame(Default::default());
    // rust: assert_eq!(slots.place("skins/a".into()), Some((0, None)));
    // rust: assert_eq!(slots.place("skins/b".into()), Some((1, None)));
    // rust: assert_eq!(slots.place("skins/c".into()), None);
    // rust: slots.next_frame(["skins/b".to_owned()].into());
    // rust: assert_eq!(
    // rust: slots.place("skins/c".into()),
    // rust: Some((0, Some("skins/a".into())))
    // rust: );
        // Stored this frame, kept through it.
    // rust: assert_eq!(slots.place("skins/d".into()), None);
    // rust: assert!(slots.contains("skins/b") && slots.contains("skins/c"));
}

    /// A skin evicted from the atlas re-uploads (`again`), once per ask.
pub fn evicted_skins_upload_again() void {
}
    // rust: let mut d = super::Downloader::new(std::env::temp_dir().join("horizon-test-skins"));
    // rust: d.remember("skins/abc".into(), vec![1, 2, 3]);
    // rust: assert!(d.again("skins/abc"));
    // rust: assert!(!d.again("skins/missing"));
        // Once queued, more asks do not pile up uploads.
    // rust: assert!(d.again("skins/abc"));
    // rust: assert_eq!(
    // rust: d.take_ready(),
    // rust: vec![("skins/abc".to_owned(), vec![1, 2, 3])]
    // rust: );
    // rust: assert!(d.take_ready().is_empty());
    // rust: assert!(d.again("skins/abc"));
    // rust: assert_eq!(d.take_ready().len(), 1);
        // The first upload marks the location queued too: an `again` before
        // `take_ready` does not put the same skin in the atlas twice.
    // rust: d.queue("skins/def".into(), vec![4]);
    // rust: assert!(d.again("skins/def"));
    // rust: assert_eq!(d.take_ready(), vec![("skins/def".to_owned(), vec![4])]);
}

    /// A cape fills the top half of a 64x64 slot; a larger one is scaled to 64x32.
pub fn capes_fill_the_top_half_of_a_slot() void {
}
    // rust: let at = |x: usize, y: usize| (y * 64 + x) * 4;
    // rust: let legacy = super::process_cape(22, 17, &[7; 22 * 17 * 4]).unwrap();
    // rust: assert_eq!(legacy.len(), 64 * 64 * 4);
    // rust: assert_eq!(legacy[at(21, 16)], 7);
    // rust: assert_eq!(legacy[at(22, 16)], 0);
    // rust: let mut hd = vec![0u8; 128 * 64 * 4];
    // rust: hd[(62 * 128 + 126) * 4] = 9;
    // rust: let hd = super::process_cape(128, 64, &hd).unwrap();
    // rust: assert_eq!(hd[at(63, 31)], 9);
    // rust: assert_eq!(hd[at(0, 32)], 0);
    // rust: assert!(super::process_cape(64, 32, &[0; 4]).is_none());
    // rust: let textures = super::Textures {
    // rust: cape: Some("http://textures.minecraft.net/texture/abc".into()),
    // rust: ..Default::default()
}
    // rust: let cape = super::cape(&textures).unwrap();
    // rust: assert_eq!(
    // rust: cape["capes/".len()..],
    // rust: super::skin_location("abc")["skins/".len()..]
    // rust: );
}

pub fn profile_components_supply_unsigned_head_skins() void {
}
    // rust: let value = "eyJ0ZXh0dXJlcyI6IHsiU0tJTiI6IHsidXJsIjogImh0dHBzOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2FiYzEyMyJ9fX0=";
    // rust: let profile = serde_json::json!({"properties": [{"name": "textures", "value": value}]});
    // rust: assert_eq!(
    // rust: super::profile_skin_url(&profile).as_deref(),
    // rust: Some("https://textures.minecraft.net/texture/abc123")
    // rust: );
    // rust: let other = serde_json::json!({"properties": [{"name": "other", "value": value}]});
    // rust: assert_eq!(super::profile_skin_url(&other), None);
    // rust: let bad = serde_json::json!({"properties": [{"name": "textures", "value": "not base64"}]});
    // rust: assert_eq!(super::profile_skin_url(&bad), None);
    // rust: assert_eq!(super::profile_skin_url(&serde_json::json!({})), None);
}

    /// Textures come over plain HTTP too (a local server here; https is the
    /// same request through rustls), and only 2xx answers count.
pub fn http_get_reads_2xx_bodies() void {
}
//         use std::io::{BufRead, BufReader, Write};
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let base = format!("http://{}", listener.local_addr().unwrap());
    // rust: std::thread::spawn(move || {
    // rust: for stream in listener.incoming().take(2) {
    // rust: let mut stream = stream.unwrap();
    // rust: let mut line = String::new();
    // rust: let mut reader = BufReader::new(stream.try_clone().unwrap());
    // rust: reader.read_line(&mut line).unwrap();
    // rust: while reader.read_line(&mut String::new()).unwrap() > 2 {}
    // rust: let reply: &[u8] = if line.contains("/texture/abc") {
    // rust: b"HTTP/1.1 200 OK\r\nContent-Length: 4\r\nConnection: close\r\n\r\nPNG!"
    // rust: } else {
    // rust: b"HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\nConnection: close\r\n\r\n"
}
    // rust: stream.write_all(reply).unwrap();
}
    // rust: });
    // rust: assert_eq!(
    // rust: http_get(&format!("{base}/texture/abc")),
    // rust: Some(b"PNG!".to_vec())
    // rust: );
    // rust: assert_eq!(http_get(&format!("{base}/texture/missing")), None);
}

//     use super::*;

pub fn skull_block_entity_profiles_supply_head_skins() void {
}
    // rust: let value = "eyJ0ZXh0dXJlcyI6IHsiU0tJTiI6IHsidXJsIjogImh0dHBzOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2FiYzEyMyJ9fX0=";
    // rust: let profile = horizon_world::nbt::parse_snbt(&format!(
    // rust: r#"{{name:"T",id:[I;-158327916,1572358581,-2125825222,-487948715],properties:[{{name:"textures",value:"{value}"}}]}}"#
    // rust: ))
    // rust: .unwrap()
    // rust: .0;
    // rust: assert_eq!(
    // rust: super::profile_skin_url_nbt(&profile).as_deref(),
    // rust: Some("https://textures.minecraft.net/texture/abc123")
    // rust: );
    // rust: assert_eq!(
    // rust: super::profile_uuid_nbt(&profile),
    // rust: Some(
    // rust: [-158327916, 1572358581, -2125825222, -487948715]
    // rust: .iter()
    // rust: .fold(0u128, |a, &w: &i32| (a << 32) | u128::from(w as u32))
    // rust: )
    // rust: );
        // A name-only profile (a string tag) has no properties: no url, no id.
    // rust: let named = horizon_world::nbt::Tag::String("MHF_Blaze".into());
    // rust: assert_eq!(super::profile_skin_url_nbt(&named), None);
    // rust: assert_eq!(super::profile_uuid_nbt(&named), None);
        // A uuid in string form decodes too.
    // rust: let text_id = horizon_world::nbt::parse_snbt(
    // rust: r#"{name:"T",id:"e843a1f4-0000-0001-0000-000200000003"}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: assert_eq!(
    // rust: super::profile_uuid_nbt(&text_id),
    // rust: Some(u128::from_str_radix("e843a1f4000000010000000200000003", 16).unwrap())
    // rust: );
}

pub fn sha1_and_base64() void {
}
    // rust: let hex: String = sha1(b"abc").iter().map(|b| format!("{b:02x}")).collect();
    // rust: assert_eq!(hex, "a9993e364706816aba3e25717850c26c9cd0d89d");
    // rust: assert_eq!(base64_decode("aGk=").unwrap(), b"hi");
    // rust: assert_eq!(base64_decode("aGk").unwrap(), b"hi");
    // rust: assert!(base64_decode("a").is_none());
    // rust: assert!(base64_decode("aGk=x").is_none());
    // rust: assert_eq!(
    // rust: texture_hash("http://textures.minecraft.net/texture/abc.png?x=1").unwrap(),
    // rust: "abc"
    // rust: );
}

    /// `SkinManager.registerTextures` waits on the skin, cape and elytra
    /// together (`CompletableFuture.allOf`): a cape or elytra that cannot be
    /// fetched, or whose URL has no hash, fails the profile, and the player
    /// shows the default skin, as the skin's own failure does.
pub fn a_failed_cape_or_elytra_shows_the_default_skin() void {
}
    // rust: let textures = super::Textures {
    // rust: skin: Some("https://textures.minecraft.net/texture/skin1".into()),
    // rust: cape: Some("https://textures.minecraft.net/texture/cape1".into()),
    // rust: elytra: Some("https://textures.minecraft.net/texture/elytra1".into()),
    // rust: signed: true,
    // rust: slim: false,
}
    // rust: let all_ready = super::lookup(&textures, true, |_, _| super::Download::Ready);
    // rust: assert_eq!(all_ready, Some(super::skin_location("skin1")));
    // rust: for failing in [super::Kind::Skin, super::Kind::Cape, super::Kind::Elytra] {
    // rust: let skin = super::lookup(&textures, true, |kind, _| {
    // rust: if kind == failing {
    // rust: super::Download::Failed
    // rust: } else {
    // rust: super::Download::Ready
}
    // rust: });
    // rust: assert_eq!(skin, None, "{failing:?} failed");
}
    // rust: let bad_cape_url = super::Textures {
    // rust: cape: Some("no-scheme".into()),
    // rust: ..textures.clone()
}
    // rust: assert_eq!(
    // rust: super::lookup(&bad_cape_url, true, |_, _| super::Download::Ready),
    // rust: None
    // rust: );
}

    /// A 1x1 PNG of `rgba`.
pub fn png(rgba: [u8; 4]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, 1, 1);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&rgba).unwrap();
    // rust: writer.finish().unwrap();
    // rust: out
}

    /// A downloaded body reaches the disk cache only if it decodes; a broken
    /// cached file is fetched again and replaced. A failed fetch writes nothing.
pub fn the_texture_cache_holds_only_what_decodes() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-test-skin-cache-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let body = png([7, 8, 9, 255]);
    // rust: let file = root.join("ab").join("abcdef");
    // rust: let load = |fetched: Option<&[u8]>| {
    // rust: let fetched = fetched.map(<[u8]>::to_vec);
    // rust: super::Downloader::load_texture(
    // rust: &root,
    // rust: super::Kind::Elytra,
    // rust: "abcdef",
    // rust: "https://example/texture/abc.png",
    // rust: |_| fetched.clone(),
    // rust: )
}
    // rust: assert_eq!(load(Some(&body)), Some(vec![7, 8, 9, 255]));
    // rust: assert_eq!(std::fs::read(&file).unwrap(), body);
        // From then on the cache answers; no fetch is needed.
    // rust: assert_eq!(load(None), Some(vec![7, 8, 9, 255]));
        // A broken file is fetched again and replaced, not kept.
    // rust: std::fs::write(&file, b"<html>not a png</html>").unwrap();
    // rust: assert_eq!(load(Some(&body)), Some(vec![7, 8, 9, 255]));
    // rust: assert_eq!(std::fs::read(&file).unwrap(), body);
        // A body that does not decode is not cached at all.
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: assert_eq!(load(Some(b"<html>not a png</html>")), None);
    // rust: assert!(!file.exists());
}

    // rust: fn wait_state(
    // rust: d: &mut super::Downloader,
    // rust: kind: super::Kind,
    // rust: url: &str,
    // rust: want: super::Download,
    // rust: ) -> super::Download {
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(10);
    // rust: loop {
    // rust: let state = d.state(kind, url);
    // rust: if state == want || std::time::Instant::now() > deadline {
    // rust: return state;
}
    // rust: std::thread::sleep(std::time::Duration::from_millis(5));
}
}

    /// A texture download that failed is tried again after the wait, instead of
    /// pinning the player to the default skin for the rest of the session.
pub fn a_failed_download_is_retried_after_the_wait() void {
}
//         use std::io::{BufRead, BufReader, Write};
//         use std::sync::atomic::{AtomicUsize, Ordering};
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let base = format!("http://{}", listener.local_addr().unwrap());
    // rust: let body = png([1, 2, 3, 4]);
    // rust: let served = std::sync::Arc::new(AtomicUsize::new(0));
    // rust: let count = served.clone();
    // rust: std::thread::spawn(move || {
    // rust: for (i, stream) in listener.incoming().take(2).enumerate() {
    // rust: let mut stream = stream.unwrap();
    // rust: let mut line = String::new();
    // rust: let mut reader = BufReader::new(stream.try_clone().unwrap());
    // rust: reader.read_line(&mut line).unwrap();
    // rust: while reader.read_line(&mut String::new()).unwrap() > 2 {}
    // rust: count.fetch_add(1, Ordering::SeqCst);
    // rust: if i == 0 {
    // rust: stream
    // rust: .write_all(
    // rust: b"HTTP/1.1 503 Service Unavailable\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    // rust: )
    // rust: .unwrap();
    // rust: } else {
    // rust: let head = format!(
    // rust: "HTTP/1.1 200 OK\r\nContent-Length: {}\r\nConnection: close\r\n\r\n",
    // rust: body.len()
    // rust: );
    // rust: stream.write_all(head.as_bytes()).unwrap();
    // rust: stream.write_all(&body).unwrap();
}
}
    // rust: });
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-test-skin-retry-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let mut d = super::Downloader::new(root);
    // rust: let url = format!("{base}/texture/retry.png");
    // rust: assert_eq!(d.state(super::Kind::Elytra, &url), super::Download::Pending);
    // rust: assert_eq!(
    // rust: wait_state(&mut d, super::Kind::Elytra, &url, super::Download::Failed),
    // rust: super::Download::Failed
    // rust: );
        // Within the wait the failure stands: no request goes out.
    // rust: assert_eq!(d.state(super::Kind::Elytra, &url), super::Download::Failed);
    // rust: assert_eq!(served.load(Ordering::SeqCst), 1);
        // After it, the download is started again and takes the good answer.
    // rust: d.retry_after = std::time::Duration::ZERO;
    // rust: assert_eq!(d.state(super::Kind::Elytra, &url), super::Download::Pending);
    // rust: assert_eq!(
    // rust: wait_state(&mut d, super::Kind::Elytra, &url, super::Download::Ready),
    // rust: super::Download::Ready
    // rust: );
    // rust: assert_eq!(served.load(Ordering::SeqCst), 2);
}
}
