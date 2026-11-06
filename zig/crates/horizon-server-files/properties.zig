//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_properties
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! server.properties (DedicatedServerProperties over Settings): every key with
//! vanilla's default, parser and serializer. Reading a value writes its
//! normalized form back, so storing afterwards rewrites the file the way the
//! vanilla server does on start; the legacy keys are dropped.
// use super::{
    // rust: java_properties::{Properties, date_string, now_millis},
    // rust: json::{self, Json},
}
// use horizon_core::random::java_string_hash;
// use horizon_protocol::crypto::md5;

/// MinecraftServer.ServerResourcePackInfo.
pub const ResourcePackInfo = struct {
    id: u128,
    url: []const u8,
    hash: []const u8,
    required: bool,
    /// The prompt component, as JSON, when it parsed.
    prompt: ?Json,
};

/// Every value DedicatedServerProperties reads, in declaration order.
pub const ServerProperties = struct {
    online_mode: bool,
    prevent_proxy_connections: bool,
    server_ip: []const u8,
    allow_flight: bool,
    motd: []const u8,
    code_of_conduct: bool,
    bug_report_link: []const u8,
    force_game_mode: bool,
    enforce_whitelist: bool,
    /// Difficulty id (0 peaceful .. 3 hard).
    difficulty: i32,
    /// GameType id (0 survival .. 3 spectator).
    game_mode: i32,
    level_name: []const u8,
    server_port: i32,
    management_server_enabled: bool,
    management_server_host: []const u8,
    management_server_port: i32,
    management_server_secret: []const u8,
    management_server_tls_enabled: bool,
    management_server_tls_keystore: []const u8,
    management_server_tls_keystore_password: []const u8,
    management_server_allowed_origins: []const u8,
    announce_player_achievements: ?bool,
    enable_query: bool,
    query_port: i32,
    enable_rcon: bool,
    rcon_port: i32,
    rcon_password: []const u8,
    hardcore: bool,
    use_native_transport: bool,
    spawn_protection: i32,
    op_permission_level: i32,
    function_permission_level: i32,
    max_tick_time: i64,
    max_chained_neighbor_updates: i32,
    rate_limit: i32,
    command_spam_threshold_seconds: i32,
    chat_spam_threshold_seconds: i32,
    view_distance: i32,
    simulation_distance: i32,
    max_players: i32,
    network_compression_threshold: i32,
    broadcast_rcon_to_ops: bool,
    broadcast_console_to_ops: bool,
    max_world_size: i32,
    sync_chunk_writes: bool,
    region_file_compression: []const u8,
    enable_jmx_monitoring: bool,
    enable_status: bool,
    hide_online_players: bool,
    entity_broadcast_range_percentage: i32,
    text_filtering_config: []const u8,
    text_filtering_version: i32,
    player_idle_timeout: i32,
    status_heartbeat_interval: i32,
    white_list: bool,
    enforce_secure_profile: bool,
    log_ips: bool,
    pause_when_empty_seconds: i32,
    accepts_transfers: bool,
    level_seed: []const u8,
    seed: i64,
    /// WorldOptions.randomSeed was used (empty level-seed).
    random_seed: bool,
    generate_structures: bool,
    generator_settings: Json,
    level_type: []const u8,
    resource_pack: ?ResourcePackInfo,
    initial_enabled_packs: std.ArrayList([]const u8),
    initial_disabled_packs: std.ArrayList([]const u8),
    /// The properties as they are stored back.
    raw: Properties,
    /// What vanilla logs while reading (resource pack warnings).
    warnings: std.ArrayList([]const u8),
};

pub const DIFFICULTIES: [[]const u8; 4] = ["peaceful", "easy", "normal", "hard"];
pub const GAME_MODES: [[]const u8; 4] = ["survival", "creative", "adventure", "spectator"];

/// Sources of the values vanilla draws at random.
    // rust: pub trait Entropy {
    /// RandomSource.create().nextLong() (WorldOptions.randomSeed).
pub fn next_long(self: *Self) i;
    /// SecureRandom.nextInt(bound).
pub fn next_int(self: *Self, bound: u32) u;
}
/// Entropy from the operating system (/dev/urandom), else the clock.
pub const SystemEntropy = struct {};
    // rust: impl Default for SystemEntropy {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut seed = [0u8; 8];
    // rust: let ok = std::fs::File::open("/dev/urandom")
    // rust: .and_then(|mut f| std::io::Read::read_exact(&mut f, &mut seed))
    // rust: .is_ok();
    // rust: let mut s = u64::from_le_bytes(seed);
    // rust: if !ok || s == 0 {
    // rust: s = now_millis() as u64 ^ 0x9E37_79B9_7F4A_7C15;
}
    // rust: Self(s)
}
}
    // rust: impl SystemEntropy {
pub fn next(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
        // splitmix64
    // rust: self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
    // rust: let mut z = self.0;
    // rust: z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    // rust: z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    // rust: z ^ (z >> 31)
}
}
    // rust: impl Entropy for SystemEntropy {
pub fn next_long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next() as i64
}
pub fn next_int(self: *Self, bound: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.next() % u64::from(bound)) as u32
}
}

/// SecurityConfig.generateSecretKey.
pub fn generate_secret_key(entropy: *mut dyn Entropy) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const ALPHABET: []const u8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    // rust: (0..40)
    // rust: .map(|_| char::from(ALPHABET[entropy.next_int(ALPHABET.len() as u32) as usize]))
    // rust: .collect()
}

/// UUID.nameUUIDFromBytes.
pub fn name_uuid(bytes: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut h = md5(bytes);
    // rust: h[6] = (h[6] & 0x0f) | 0x30;
    // rust: h[8] = (h[8] & 0x3f) | 0x80;
    // rust: u128::from_be_bytes(h)
}

/// UUID.fromString (the lenient JDK parser: five dash-separated hex groups).
pub fn parse_uuid(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parts: Vec<&str> = s.split('-').collect();
    // rust: if parts.len() != 5 || s.len() > 36 {
    // rust: return None;
}
    // rust: let mut v = [0u64; 5];
    // rust: for (i, p) in parts.iter().enumerate() {
    // rust: if p.is_empty() || p.len() > 16 {
    // rust: return None;
}
    // rust: v[i] = u64::from_str_radix(p, 16).ok()?;
}
    // rust: let msb = (v[0] & 0xffff_ffff) << 32 | (v[1] & 0xffff) << 16 | (v[2] & 0xffff);
    // rust: let lsb = (v[3] & 0xffff) << 48 | (v[4] & 0xffff_ffff_ffff);
    // rust: Some(u128::from(msb) << 64 | u128::from(lsb))
}

/// Boolean.valueOf.
pub fn java_bool(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.eq_ignore_ascii_case("true")
}

pub const Reader = struct {
    p: Properties,
};
    // rust: impl Reader {
pub fn raw(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.get(key).map(str::to_owned)
}
    // rust: fn get<V>(
    // rust: &mut self,
    // rust: key: &str,
    // rust: de: impl Fn(&str) -> Option<V>,
    // rust: ser: impl Fn(&V) -> String,
    // rust: default: V,
    // rust: ) -> V {
    // rust: let v = self.raw(key).and_then(|s| de(&s)).unwrap_or(default);
    // rust: self.p.put(key, ser(&v));
    // rust: v
}
pub fn string(self: *Self, key: []const u8, default: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(
    // rust: key,
    // rust: |s| Some(s.to_owned()),
    // rust: String::clone,
    // rust: default.to_owned(),
    // rust: )
}
pub fn int(self: *Self, key: []const u8, default: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(key, |s| s.parse().ok(), i32::to_string, default)
}
pub fn long(self: *Self, key: []const u8, default: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(key, |s| s.parse().ok(), i64::to_string, default)
}
pub fn boolean(self: *Self, key: []const u8, default: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(key, |s| Some(java_bool(s)), bool::to_string, default)
}
pub fn legacy(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.remove(key)
}
pub fn permission(self: *Self, key: []const u8, default: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(
    // rust: key,
    // rust: |s| s.parse::<i32>().ok().map(|v| v.clamp(0, 4)),
    // rust: i32::to_string,
    // rust: default,
    // rust: )
}
}

    // rust: impl ServerProperties {
    /// DedicatedServerProperties.fromFile; a file that cannot be read is an
    /// empty set (Settings.loadFromFile logs and continues).
pub fn from_file(path: *std::path::Path, entropy: *mut dyn Entropy) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = match std::fs::read(path) {
    // rust: Ok(bytes) => Properties::load_file(&bytes).map_err(|e| e.to_string())?,
    // rust: Err(_) => Properties::default(),
}
    // rust: Self::new(p, entropy)
}

    /// The constructor: field initializers, then the constructor body.
pub fn new(properties: Properties, entropy: *mut dyn Entropy) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader { p: properties };
    // rust: let mut warnings = Vec::new();
    // rust: let online_mode = r.boolean("online-mode", true);
    // rust: let prevent_proxy_connections = r.boolean("prevent-proxy-connections", false);
    // rust: let server_ip = r.string("server-ip", "");
    // rust: let allow_flight = r.boolean("allow-flight", false);
    // rust: let motd = r.string("motd", "A Minecraft Server");
    // rust: let code_of_conduct = r.boolean("enable-code-of-conduct", false);
    // rust: let bug_report_link = r.string("bug-report-link", "");
    // rust: let force_game_mode = r.boolean("force-gamemode", false);
    // rust: let enforce_whitelist = r.boolean("enforce-whitelist", false);
    // rust: let difficulty = r.get(
    // rust: "difficulty",
    // rust: |s| match s.parse::<i32>() {
    // rust: Ok(id) => Some(id.rem_euclid(4)),
    // rust: Err(_) => DIFFICULTIES.iter().position(|n| *n == s).map(|i| i as i32),
    // rust: },
    // rust: |d| DIFFICULTIES[*d as usize].to_owned(),
    // rust: 1,
    // rust: );
    // rust: let game_mode = r.get(
    // rust: "gamemode",
    // rust: |s| match s.parse::<i32>() {
    // rust: Ok(id) => Some(if (0..4).contains(&id) { id } else { 0 }),
    // rust: Err(_) => Some(GAME_MODES.iter().position(|n| *n == s).unwrap_or(0) as i32),
    // rust: },
    // rust: |g| GAME_MODES[*g as usize].to_owned(),
    // rust: 0,
    // rust: );
    // rust: let level_name = r.string("level-name", "world");
    // rust: let server_port = r.int("server-port", 25565);
    // rust: let management_server_enabled = r.boolean("management-server-enabled", false);
    // rust: let management_server_host = r.string("management-server-host", "localhost");
    // rust: let management_server_port = r.int("management-server-port", 0);
    // rust: let secret = generate_secret_key(entropy);
    // rust: let management_server_secret = r.string("management-server-secret", &secret);
    // rust: let management_server_tls_enabled = r.boolean("management-server-tls-enabled", true);
    // rust: let management_server_tls_keystore = r.string("management-server-tls-keystore", "");
    // rust: let management_server_tls_keystore_password =
    // rust: r.string("management-server-tls-keystore-password", "");
    // rust: let management_server_allowed_origins = r.string("management-server-allowed-origins", "");
    // rust: let announce_player_achievements = r
    // rust: .legacy("announce-player-achievements")
    // rust: .map(|s| java_bool(&s));
    // rust: let enable_query = r.boolean("enable-query", false);
    // rust: let query_port = r.int("query.port", 25565);
    // rust: let enable_rcon = r.boolean("enable-rcon", false);
    // rust: let rcon_port = r.int("rcon.port", 25575);
    // rust: let rcon_password = r.string("rcon.password", "");
    // rust: let hardcore = r.boolean("hardcore", false);
    // rust: let use_native_transport = r.boolean("use-native-transport", true);
    // rust: let spawn_protection = r.int("spawn-protection", 16);
    // rust: let op_permission_level = r.permission("op-permission-level", 4);
    // rust: let function_permission_level = r.permission("function-permission-level", 2);
    // rust: let max_tick_time = r.long("max-tick-time", 60_000);
    // rust: let max_chained_neighbor_updates = r.int("max-chained-neighbor-updates", 1_000_000);
    // rust: let rate_limit = r.int("rate-limit", 0);
    // rust: let command_spam_threshold_seconds = r.int("command-spam-threshold-seconds", 10);
    // rust: let chat_spam_threshold_seconds = r.int("chat-spam-threshold-seconds", 10);
    // rust: let view_distance = r.int("view-distance", 10);
    // rust: let simulation_distance = r.int("simulation-distance", 10);
    // rust: let max_players = r.int("max-players", 20);
    // rust: let network_compression_threshold = r.int("network-compression-threshold", 256);
    // rust: let broadcast_rcon_to_ops = r.boolean("broadcast-rcon-to-ops", true);
    // rust: let broadcast_console_to_ops = r.boolean("broadcast-console-to-ops", true);
    // rust: let max_world_size = r.get(
    // rust: "max-world-size",
    // rust: |s| s.parse::<i32>().ok().map(|v| v.clamp(1, 29_999_984)),
    // rust: i32::to_string,
    // rust: 29_999_984,
    // rust: );
    // rust: let sync_chunk_writes = r.boolean("sync-chunk-writes", true);
    // rust: let region_file_compression = r.string("region-file-compression", "deflate");
    // rust: let enable_jmx_monitoring = r.boolean("enable-jmx-monitoring", false);
    // rust: let enable_status = r.boolean("enable-status", true);
    // rust: let hide_online_players = r.boolean("hide-online-players", false);
        // Its deserializer is not wrapped: a non-number throws out of the constructor.
    // rust: let entity_broadcast_range_percentage = match r.raw("entity-broadcast-range-percentage") {
    // rust: Some(s) => s.parse::<i32>().map(|v| v.clamp(10, 1000)).map_err(|_| {
    // rust: format!("java.lang.NumberFormatException: For input string: \"{s}\"")
    // rust: })?,
    // rust: None => 100,
}
    // rust: r.p.put(
    // rust: "entity-broadcast-range-percentage",
    // rust: entity_broadcast_range_percentage.to_string(),
    // rust: );
    // rust: let text_filtering_config = r.string("text-filtering-config", "");
    // rust: let text_filtering_version = r.int("text-filtering-version", 0);
    // rust: let player_idle_timeout = r.int("player-idle-timeout", 0);
    // rust: let status_heartbeat_interval = r.int("status-heartbeat-interval", 0);
    // rust: let white_list = r.boolean("white-list", true);
    // rust: let enforce_secure_profile = r.boolean("enforce-secure-profile", true);
    // rust: let log_ips = r.boolean("log-ips", true);
    // rust: let pause_when_empty_seconds = r.int("pause-when-empty-seconds", 60);
    // rust: let accepts_transfers = r.boolean("accepts-transfers", false);
        // The constructor body.
    // rust: let level_seed = r.string("level-seed", "");
    // rust: let generate_structures = r.boolean("generate-structures", true);
    // rust: let (seed, random_seed) = match parse_seed(&level_seed) {
    // rust: Some(s) => (s, false),
    // rust: None => (entropy.next_long(), true),
}
    // rust: let generator_settings = match r.raw("generator-settings") {
    // rust: Some(s) => {
    // rust: let text = if s.is_empty() { "{}" } else { s.as_str() };
    // rust: match json::parse(text, false) {
    // rust: Ok(v @ Json::Object(_)) => v,
    // rust: Ok(_) => return Err("com.google.gson.JsonSyntaxException: Expected a com.google.gson.JsonObject".into()),
    // rust: Err(e) => return Err(format!("com.google.gson.JsonParseException: {e}")),
}
}
    // rust: None => Json::Object(Vec::new()),
}
    // rust: r.p.put("generator-settings", generator_settings.compact());
    // rust: let level_type = r.get(
    // rust: "level-type",
    // rust: |s| Some(s.to_lowercase()),
    // rust: String::clone,
    // rust: "minecraft:normal".to_owned(),
    // rust: );
    // rust: let pack_id = r.string("resource-pack-id", "");
    // rust: let pack_url = r.string("resource-pack", "");
    // rust: let pack_sha1 = r.string("resource-pack-sha1", "");
    // rust: let pack_hash = r.legacy("resource-pack-hash");
    // rust: let pack_required = r.boolean("require-resource-pack", false);
    // rust: let pack_prompt = r.string("resource-pack-prompt", "");
    // rust: let resource_pack = server_pack_info(
    // rust: &pack_id,
    // rust: &pack_url,
    // rust: &pack_sha1,
    // rust: pack_hash.as_deref(),
    // rust: pack_required,
    // rust: &pack_prompt,
    // rust: &mut warnings,
    // rust: );
    // rust: let enabled = r.string("initial-enabled-packs", "vanilla");
    // rust: let disabled = r.string("initial-disabled-packs", "");
    // rust: let split = |s: &str| {
    // rust: s.split(',')
    // rust: .map(|p| p.trim().to_owned())
    // rust: .collect::<Vec<_>>()
}
    // rust: Ok(Self {
    // rust: online_mode,
    // rust: prevent_proxy_connections,
    // rust: server_ip,
    // rust: allow_flight,
    // rust: motd,
    // rust: code_of_conduct,
    // rust: bug_report_link,
    // rust: force_game_mode,
    // rust: enforce_whitelist,
    // rust: difficulty,
    // rust: game_mode,
    // rust: level_name,
    // rust: server_port,
    // rust: management_server_enabled,
    // rust: management_server_host,
    // rust: management_server_port,
    // rust: management_server_secret,
    // rust: management_server_tls_enabled,
    // rust: management_server_tls_keystore,
    // rust: management_server_tls_keystore_password,
    // rust: management_server_allowed_origins,
    // rust: announce_player_achievements,
    // rust: enable_query,
    // rust: query_port,
    // rust: enable_rcon,
    // rust: rcon_port,
    // rust: rcon_password,
    // rust: hardcore,
    // rust: use_native_transport,
    // rust: spawn_protection,
    // rust: op_permission_level,
    // rust: function_permission_level,
    // rust: max_tick_time,
    // rust: max_chained_neighbor_updates,
    // rust: rate_limit,
    // rust: command_spam_threshold_seconds,
    // rust: chat_spam_threshold_seconds,
    // rust: view_distance,
    // rust: simulation_distance,
    // rust: max_players,
    // rust: network_compression_threshold,
    // rust: broadcast_rcon_to_ops,
    // rust: broadcast_console_to_ops,
    // rust: max_world_size,
    // rust: sync_chunk_writes,
    // rust: region_file_compression,
    // rust: enable_jmx_monitoring,
    // rust: enable_status,
    // rust: hide_online_players,
    // rust: entity_broadcast_range_percentage,
    // rust: text_filtering_config,
    // rust: text_filtering_version,
    // rust: player_idle_timeout,
    // rust: status_heartbeat_interval,
    // rust: white_list,
    // rust: enforce_secure_profile,
    // rust: log_ips,
    // rust: pause_when_empty_seconds,
    // rust: accepts_transfers,
    // rust: level_seed,
    // rust: seed,
    // rust: random_seed,
    // rust: generate_structures,
    // rust: generator_settings,
    // rust: level_type,
    // rust: resource_pack,
    // rust: initial_enabled_packs: split(&enabled),
    // rust: initial_disabled_packs: split(&disabled),
    // rust: raw: r.p,
    // rust: warnings,
    // rust: })
}

    /// Settings.store: the file the server writes back.
pub fn stored(self: *Self, millis: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.raw.store(
    // rust: Some("Minecraft server properties"),
    // rust: &date_string(millis),
    // rust: false,
    // rust: )
}
pub fn store(self: *Self, path: *std::path::Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::write(path, self.stored(now_millis()))
}

    /// MutableValue.update: change one key and re-read everything (the
    /// random defaults are drawn again only for keys still absent, which
    /// never happens after the first read).
pub fn update(self: *Self, key: []const u8, value: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = self.raw.clone();
    // rust: p.put(key, value);
    // rust: Self::new(p, &mut SystemEntropy::default())
}
}

/// WorldOptions.parseSeed: empty is none, a long is itself, anything else
/// hashes as a Java string.
pub fn parse_seed(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = s.trim_matches(|c: char| c <= ' ');
    // rust: if s.is_empty() {
    // rust: return None;
}
    // rust: Some(
    // rust: s.parse::<i64>()
    // rust: .unwrap_or_else(|_| i64::from(java_string_hash(s.encode_utf16()))),
    // rust: )
}

    // rust: fn server_pack_info(
    // rust: id: &str,
    // rust: url: &str,
    // rust: sha1: &str,
    // rust: legacy_hash: Option<&str>,
    // rust: required: bool,
    // rust: prompt: &str,
    // rust: warnings: &mut Vec<String>,
    // rust: ) -> Option<ResourcePackInfo> {
    // rust: if url.is_empty() {
    // rust: return None;
}
    // rust: let hash = if !sha1.is_empty() {
    // rust: if legacy_hash.is_some_and(|h| !h.is_empty()) {
    // rust: warnings.push("resource-pack-hash is deprecated and found along side resource-pack-sha1. resource-pack-hash will be ignored.".into());
}
    // rust: sha1.to_owned()
    // rust: } else if let Some(h) = legacy_hash.filter(|h| !h.is_empty()) {
    // rust: warnings.push(
    // rust: "resource-pack-hash is deprecated. Please use resource-pack-sha1 instead.".into(),
    // rust: );
    // rust: h.to_owned()
    // rust: } else {
    // rust: String::new()
}
    // rust: if hash.is_empty() {
    // rust: warnings.push("You specified a resource pack without providing a sha1 hash. Pack will be updated on the client only if you change the name of the pack.".into());
    // rust: } else if !(hash.len() == 40 && hash.chars().all(|c| c.is_ascii_hexdigit())) {
    // rust: warnings.push("Invalid sha1 for resource-pack-sha1".into());
}
    // rust: let prompt = parse_prompt(prompt, warnings);
    // rust: let id = if id.is_empty() {
    // rust: let uuid = name_uuid(url.as_bytes());
    // rust: warnings.push(format!(
    // rust: "resource-pack-id missing, using default of {}",
    // rust: horizon_protocol::crypto::uuid_string(uuid)
    // rust: ));
    // rust: uuid
    // rust: } else {
    // rust: match parse_uuid(id) {
    // rust: Some(u) => u,
    // rust: None => {
    // rust: warnings.push(format!("Failed to parse '{id}' into UUID"));
    // rust: return None;
}
}
}
    // rust: Some(ResourcePackInfo {
    // rust: id,
    // rust: url: url.to_owned(),
    // rust: hash,
    // rust: required,
    // rust: prompt,
    // rust: })
}

/// DedicatedServerProperties.parseResourcePackPrompt: strict JSON decoded as
/// a component (a string, an array of components, or an object with content).
pub fn parse_prompt(prompt: []const u8, warnings: *mut std.ArrayList([]const u8)) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if prompt.is_empty() {
    // rust: return None;
}
    // rust: match json::parse(prompt, true) {
    // rust: Ok(v) if is_component(&v) => Some(v),
    // rust: Ok(_) => {
    // rust: warnings.push(format!("Failed to parse resource pack prompt '{prompt}'"));
    // rust: None
}
    // rust: Err(_) => {
    // rust: warnings.push(format!("Failed to parse resource pack prompt '{prompt}'"));
    // rust: None
}
}
}
pub fn is_component(v: *Json) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Json::String(_) | Json::Number(_) | Json::Bool(_) => true,
    // rust: Json::Array(items) => !items.is_empty() && items.iter().all(is_component),
    // rust: Json::Object(m) => [
    // rust: "text",
    // rust: "translate",
    // rust: "score",
    // rust: "selector",
    // rust: "keybind",
    // rust: "nbt",
    // rust: "object",
    // rust: ]
    // rust: .iter()
    // rust: .any(|k| m.iter().any(|(n, _)| n == k)),
    // rust: Json::Null => false,
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::java_properties::line_separator;
pub const Fixed = struct {};
    // rust: impl Entropy for Fixed {
pub fn next_long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 7
}
pub fn next_int(self: *Self, _: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
}
pub fn defaults_match_vanilla_init_settings() void {
}
    // rust: let p = ServerProperties::new(Properties::default(), &mut Fixed).unwrap();
        // Lines end in System.lineSeparator() (java_properties checks that): read them as "\n".
    // rust: let stored = p.stored(0).replace(line_separator(), "\n");
    // rust: assert!(stored.starts_with(
    // rust: "#Minecraft server properties\n#Thu Jan 01 00:00:00 UTC 1970\naccepts-transfers=false\n"
    // rust: ));
    // rust: assert!(stored.contains("\nlevel-type=minecraft\\:normal\n"));
    // rust: assert!(
    // rust: stored
    // rust: .contains("\nmanagement-server-secret=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n")
    // rust: );
    // rust: assert!(stored.ends_with("\nview-distance=10\nwhite-list=true\n"));
    // rust: assert_eq!(stored.lines().count(), 71);
    // rust: assert!(p.random_seed);
    // rust: assert_eq!(p.seed, 7);
}
pub fn parses_like_vanilla() void {
}
    // rust: let mut raw = Properties::default();
    // rust: raw.put("difficulty", "-1".into());
    // rust: raw.put("gamemode", "bogus".into());
    // rust: raw.put("op-permission-level", "9".into());
    // rust: raw.put("level-seed", "hello".into());
    // rust: raw.put("level-type", "FLAT".into());
    // rust: raw.put("announce-player-achievements", "true".into());
    // rust: let p = ServerProperties::new(raw, &mut Fixed).unwrap();
    // rust: assert_eq!(
    // rust: (p.difficulty, p.game_mode, p.op_permission_level),
    // rust: (3, 0, 4)
    // rust: );
    // rust: assert_eq!(p.seed, 99_162_322);
    // rust: assert_eq!(p.level_type, "flat");
    // rust: assert_eq!(p.announce_player_achievements, Some(true));
    // rust: assert!(p.raw.get("announce-player-achievements").is_none());
    // rust: assert_eq!(
    // rust: parse_uuid("1-2-3-4-5"),
    // rust: Some(0x0000_0001_0002_0003_0004_0000_0000_0005)
    // rust: );
}
}
