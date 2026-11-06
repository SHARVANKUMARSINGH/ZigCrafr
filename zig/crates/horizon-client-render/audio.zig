//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_audio
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sound playback: vanilla's `SoundEngine` bookkeeping (`sound_engine`) over a
//! small mixer standing in for OpenAL: one channel per source with its gain,
//! pitch, linear distance attenuation (`AL_LINEAR_DISTANCE`, reference 0,
//! rolloff 1), looping, relative flag and source state, Ogg/Vorbis decoding
//! (streams on a worker thread) and OpenAL Soft's stereo panning.
// use crate::Result;
// use crate::sound_engine::{
    // rust: Attenuation, Backend, Bound, ChannelId, InstanceId, PlayResult, SoundEngine, SoundInstance,
    // rust: Sounds, TickContext,
}
// use crate::sound_events::{Sound, SoundRegistry};
// use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
}

/// An OpenAL source's state.
pub const State = enum {
    Initial,
    Playing,
    Paused,
    Stopped,
};
/// An OpenAL source.
pub const Channel = struct {
    samples: ?(Arc<std.ArrayList(f32),
    position: f64,
    state: State,
    gain: f32,
    pitch: f32,
    /// `AL_LINEAR_DISTANCE` max distance, or no attenuation.
    linear: ?f32,
    looping: bool,
    at: [f32,
    relative: bool,
    /// Whose sounds these are: 0 the game's, another splitscreen player's (`Audio::share`).
    owner: u8,
    /// Its world (`Mixer::world_id`; 0 none).
    world: u32,
    /// The sound file it started and when, to tell another player's copy of it.
    started: Option<([]const u8,
};
pub const Mixer = struct {
    channels: HashMap<ChannelId,
    listener: [f64,
    listener_yaw: f32,
    listener_pitch: f32,
    /// Splitscreen: the other players' cameras (position, yaw, pitch) by owner. A world sound is
    /// heard from the nearest camera, and panned half as wide while several share the speakers.
    listeners: HashMap<u8,
    /// Each camera's world by owner, as ids: the callback compares and copies integers.
    worlds: HashMap<u8,
    /// World names by id - 1 (`world_id`).
    world_names: std.ArrayList([]const u8),
    /// The callback's cameras (position, basis, world), kept to be refilled without allocating.
    cameras: Vec<([f64,
    /// Per-source gain/pan/step cache for one buffer, reused across callbacks.
    voices: Vec<(ChannelId,
    limiter_peak: f32,
    /// The output device the stream was opened on (`Library.currentDeviceName`).
    device_name: []const u8,
    /// The stream reported its device gone (`Library.isCurrentDeviceDisconnected`).
    device_lost: bool,
};
/// A camera's forward, up and right vectors.
    // rust: type Basis = ([f64; 3], [f64; 3], [f64; 3]);
    // rust: impl Mixer {
    /// The id of world `name` (1 and up), given once per name.
pub fn world_id(self: *Self, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = match self.world_names.iter().position(|w| w == name) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: self.world_names.push(name.to_owned());
    // rust: self.world_names.len() - 1
}
}
    // rust: i as u32 + 1
}
}
/// A sound the player could have heard (`SoundEventListener.onPlaySound`):
/// what the subtitle overlay needs.
pub const Heard = struct {
    /// The `subtitle` translation key of the sound event.
    subtitle: []const u8,
    /// The instance's position (relative sounds report their raw coordinates).
    at: Option<[f64,
    /// `SoundEngine.getRange`: infinite for relative and non-attenuated sounds.
    range: f32,
    looping: bool,
};
/// The mixer side of the engine (`Backend`).
pub const MixerBackend = struct {
    mixer: *Mutex<Mixer>,
    root: PathBuf,
    cache: *Mutex<SoundCache>,
    /// The decoder thread for static sounds, started with the first one.
    decoder: ?std::sync::mpsc::Sender<Decode>,
    next: ChannelId,
    live: bool,
    /// Whose channels these are (`Channel::owner`).
    owner: u8,
    world: u32,
    /// How many other players share this output: alone, a sound never looks for its copy.
    shares: *std::sync::atomic::AtomicUsize,
};
/// A splitscreen player's backend leaving: its camera and sounds go with it.
    // rust: impl Drop for MixerBackend {
pub fn drop(self: *Self) void {
}
    // rust: if self.owner == 0 {
    // rust: return;
}
    // rust: self.shares
    // rust: .fetch_sub(1, std::sync::atomic::Ordering::Relaxed);
    // rust: if let Ok(mut m) = self.mixer.lock() {
    // rust: m.listeners.remove(&self.owner);
    // rust: m.worlds.remove(&self.owner);
    // rust: let owner = self.owner;
    // rust: m.channels.retain(|_, c| c.owner != owner);
}
}
}
/// Splitscreen: each shared backend's channel ids start at a block of their own, never handed out
/// again, so a player in a seat used before never reuses an id a departed one's decoder may
/// still attach to. The game's own backend counts from 0, as before.
pub const SHARED_CHANNELS: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
/// Two players' copies of one sound: started within this of each other.
pub const SAME_SOUND: std::time::Duration = std::time::Duration::from_millis(150);
/// Decoded samples and their rate (`None`: the file did not load).
    // rust: type Samples = Option<(Arc<Vec<f32>>, u32)>;
/// Decoded static sounds (`SoundBufferLibrary`'s buffers), dropped least
/// recently used first past `CACHE_BYTES`: kept forever, every sound heard in
/// a session stayed (up to 1.4 GiB of samples, villages playing hundreds).
pub const SoundCache = struct {
    entries: HashMap<[]const u8,
    bytes: usize,
    clock: u64,
};
pub const CACHE_BYTES: usize = 64 << 20;
    // rust: impl SoundCache {
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clock += 1;
    // rust: let entry = self.entries.get_mut(key)?;
    // rust: entry.1 = self.clock;
    // rust: Some(entry.0.clone())
}
pub fn insert(self: *Self, key: []const u8, samples: Samples) void {
}
    // rust: self.clock += 1;
    // rust: self.bytes += Self::size(&samples);
    // rust: if let Some((old, _)) = self.entries.insert(key, (samples, self.clock)) {
    // rust: self.bytes -= Self::size(&old);
}
    // rust: while self.bytes > CACHE_BYTES && self.entries.len() > 1 {
    // rust: let Some(oldest) = self
    // rust: .entries
    // rust: .iter()
    // rust: .min_by_key(|(_, (_, used))| *used)
    // rust: .map(|(k, _)| k.clone())
    // rust: else {
    // rust: break;
}
    // rust: if let Some((gone, _)) = self.entries.remove(&oldest) {
    // rust: self.bytes -= Self::size(&gone);
}
}
}
pub fn size(samples: *Samples) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: samples
    // rust: .as_ref()
    // rust: .map_or(0, |(s, _)| s.len() * std::mem::size_of::<f32>())
}
}
/// A static sound to decode for a channel waiting on it.
pub const Decode = struct {
    key: []const u8,
    file: PathBuf,
    channel: ChannelId,
    looping: bool,
};
/// Give a channel waiting on its sound the decoded samples and start it, as
/// the buffer future attaching and playing the source. A source stopped or
/// released meanwhile stays so.
pub fn attach(mixer: *Mutex<Mixer>, channel: ChannelId, samples: Samples, looping: bool) void {
}
    // rust: if let Some(samples) = samples
    // rust: && let Ok(mut m) = mixer.lock()
    // rust: && let Some(c) = m.channels.get_mut(&channel)
    // rust: && c.state == State::Initial
    // rust: {
    // rust: c.samples = Some(samples);
    // rust: c.position = 0.0;
    // rust: c.state = State::Playing;
    // rust: c.looping |= looping;
}
}
/// The open output stream. A build without the `audio` feature (the server build, which must not
/// need libasound) never has one.
    // rust: type Stream = cpal::Stream;
    // rust: type Stream = std::convert::Infallible;
/// A level sound retained for the network broadcaster, in playback order.
pub const CapturedSound = struct {
    event: []const u8,
    position: [f64,
    volume: f32,
    pitch: f32,
    source: usize,
    entity: ?u32,
    except_entity: ?u32,
};

pub const Audio = struct {
    _stream: ?Stream,
    device_name: []const u8,
    engine: SoundEngine,
    backend: MixerBackend,
    /// Record `Heard` sounds (the subtitle overlay is listening).
    record_heard: bool,
    listener: [f64,
    listener_yaw: f32,
    master: f32,
    /// Seeds of positional plays (the client level random's `nextLong`).
    random: LegacyRandom,
    /// A `SoundSource` index the next sound plays on (`/playsound`).
    source_override: ?usize,
    /// Positional sounds played since the last drain, kept while the world
    /// is open to the network so guests hear them too.
    capture: ?std.ArrayList(CapturedSound),
    /// How many times each positional sound played (the control socket's `status`),
    /// with or without an audio device.
    heard: std::collections::BTreeMap<[]const u8,
    /// How many times each selection was stopped ("record *", "* minecraft:…", `*` for
    /// any), with or without an audio device, as `heard`.
    stopped: std::collections::BTreeMap<[]const u8,
    /// The volume sliders' `SoundPreviewHandler`.
    preview: crate::sound_preview::SoundPreview,
    /// `SoundEngine.lastSeenDevices`: the system default output last seen.
    default_seen: ?[]const u8,
    /// The ALSA cards (Linux) or Core Audio devices (macOS) last seen: listing
    /// the output devices probes every one, so it waits for these to change
    /// (`card_fingerprint`).
    cards_seen: ?[]const u8,
    /// The other half of `lastSeenDevices`: every output device last seen.
    devices_seen: std.ArrayList([]const u8),
    /// Ticks since the output devices were last looked at (`DeviceTracker.tick`).
    device_ticks: u32,
};
pub fn decode(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use symphonia::core::{
    // rust: audio::SampleBuffer, codecs::DecoderOptions, formats::FormatOptions, io::MediaSourceStream,
    // rust: meta::MetadataOptions, probe::Hint,
}
    // rust: let file = fs::File::open(path).ok()?;
    // rust: let stream = MediaSourceStream::new(Box::new(file), Default::default());
    // rust: let mut hint = Hint::new();
    // rust: hint.with_extension("ogg");
    // rust: let probed = symphonia::default::get_probe()
    // rust: .format(
    // rust: &hint,
    // rust: stream,
    // rust: &FormatOptions::default(),
    // rust: &MetadataOptions::default(),
    // rust: )
    // rust: .ok()?;
    // rust: let mut format = probed.format;
    // rust: let track = format.default_track()?;
    // rust: let id = track.id;
    // rust: let rate = track.codec_params.sample_rate?;
    // rust: let mut decoder = symphonia::default::get_codecs()
    // rust: .make(&track.codec_params, &DecoderOptions::default())
    // rust: .ok()?;
    // rust: let mut mono = Vec::new();
    // rust: while let Ok(packet) = format.next_packet() {
    // rust: if packet.track_id() != id {
    // rust: continue;
}
    // rust: let Ok(buffer) = decoder.decode(&packet) else {
    // rust: continue;
}
    // rust: let spec = *buffer.spec();
    // rust: let channels = spec.channels.count().max(1);
    // rust: let mut samples = SampleBuffer::<f32>::new(buffer.capacity() as u64, spec);
    // rust: samples.copy_interleaved_ref(buffer);
    // rust: for frame in samples.samples().chunks(channels) {
    // rust: mono.push(frame.iter().sum::<f32>() / channels as f32);
}
}
    // rust: Some((mono, rate))
}
/// A sound file without its variant number (`mob/creeper/say2.ogg` is `mob/creeper/say`): each
/// player's game picks its own variant of the same event.
// ponytail: variants named by a trailing number, as vanilla's are; the event name if a pack breaks it.
pub fn variantless(key: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key.trim_end_matches(".ogg")
    // rust: .trim_end_matches(|c: char| c.is_ascii_digit())
}
    // rust: impl MixerBackend {
    /// Splitscreen: another player's game started this same sound here just now (both clients
    /// heard it); this copy stays stopped, the first is heard from the nearest camera.
    ///
    /// A copy is recognised only by its file (without the variant), world, place and time: the
    /// games pick variants on their own and play many sounds client-side (steps, digging), so
    /// nothing marks two copies of one event. Two different events alike in all four (two
    /// players' steps on grass, side by side, within 150 ms) are heard once. That is accepted:
    /// at that distance and timing they sound like one; a doubled sound is the louder fault.
pub fn duplicate(self: *Self, channel: ChannelId) void {
}
        // Alone: nobody else's copy, and no lock taken for it.
    // rust: if self.shares.load(std::sync::atomic::Ordering::Relaxed) == 0 {
    // rust: return false;
}
    // rust: let Ok(mut m) = self.mixer.lock() else {
    // rust: return false;
}
        // Alone (no other player's camera), or a sound by the listener (a click, music): its own.
    // rust: let Some(c) = m.channels.get(&channel).filter(|c| !c.relative) else {
    // rust: return false;
}
    // rust: if m.listeners.is_empty() {
    // rust: return false;
}
    // rust: let key = format!("{namespace}:{path}");
    // rust: let key = variantless(&key);
    // rust: let at = c.at;
    // rust: let world = c.world;
    // rust: let twin = m.channels.values().any(|o| {
    // rust: o.owner != self.owner
    // rust: && o.world == world
    // rust: && !o.relative
    // rust: && o.started
    // rust: .as_ref()
    // rust: .is_some_and(|(k, t)| k == key && t.elapsed() < SAME_SOUND)
    // rust: && (0..3).map(|i| (o.at[i] - at[i]).powi(2)).sum::<f32>() < 4.0
    // rust: });
    // rust: if let Some(c) = m.channels.get_mut(&channel) {
    // rust: if twin {
    // rust: c.state = State::Stopped;
    // rust: } else {
    // rust: c.started = Some((key.to_owned(), std::time::Instant::now()));
}
}
    // rust: twin
}
pub fn with(self: *Self, channel: ChannelId, f: impl FnOnce(*mut Channel) void {
}
    // rust: if let Ok(mut m) = self.mixer.lock()
    // rust: && let Some(c) = m.channels.get_mut(&channel)
    // rust: {
    // rust: f(c);
}
}
}
    // rust: impl Backend for MixerBackend {
pub fn create(self: *Self, _streaming: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next += 1;
    // rust: let id = self.next;
    // rust: self.mixer.lock().ok()?.channels.insert(
    // rust: id,
    // rust: Channel {
    // rust: samples: None,
    // rust: position: 0.0,
    // rust: state: State::Initial,
    // rust: gain: 1.0,
    // rust: pitch: 1.0,
    // rust: linear: None,
    // rust: looping: false,
    // rust: at: [0.0; 3],
    // rust: relative: false,
    // rust: owner: self.owner,
    // rust: world: self.world,
    // rust: started: None,
    // rust: },
    // rust: );
    // rust: Some(id)
}
pub fn destroy(self: *Self, channel: ChannelId) void {
}
    // rust: if let Ok(mut m) = self.mixer.lock() {
    // rust: m.channels.remove(&channel);
}
}
pub fn set_pitch(self: *Self, channel: ChannelId, pitch: f32) void {
}
    // rust: self.with(channel, |c| c.pitch = pitch);
}
pub fn set_volume(self: *Self, channel: ChannelId, volume: f32) void {
}
    // rust: self.with(channel, |c| c.gain = volume);
}
pub fn set_attenuation(self: *Self, channel: ChannelId, linear: ?f32) void {
}
    // rust: self.with(channel, |c| c.linear = linear);
}
pub fn set_looping(self: *Self, channel: ChannelId, looping: bool) void {
}
    // rust: self.with(channel, |c| c.looping = looping);
}
pub fn set_position(self: *Self, channel: ChannelId, p: [f64; 3]) void {
}
    // rust: self.with(channel, |c| c.at = [p[0] as f32, p[1] as f32, p[2] as f32]);
}
pub fn set_relative(self: *Self, channel: ChannelId, relative: bool) void {
}
    // rust: self.with(channel, |c| c.relative = relative);
}
    /// `getCompleteBuffer` (cached, else decoded on the decoder thread) or
    /// `getStream` (decoded on a thread of its own), then attach and
    /// `alSourcePlay`. A sound that cannot load leaves its source initial,
    /// as a failed buffer future does in vanilla.
pub fn start(self: *Self, channel: ChannelId, sound: *Sound, looping: bool) void {
}
    // rust: if !self.live {
    // rust: return;
}
    // rust: let (namespace, path) = sound.path();
    // rust: let file = self.root.join("assets").join(namespace).join(&path);
        // A looping sound follows its entity in one client's tracking only: each keeps its own.
    // rust: if !looping && self.duplicate(channel, (namespace, &path)) {
    // rust: return;
}
    // rust: if sound.stream {
            // A streamed sound loops by restarting its stream.
    // rust: let mixer = self.mixer.clone();
    // rust: std::thread::spawn(move || {
    // rust: let samples = decode(&file).map(|(s, r)| (Arc::new(s), r));
    // rust: attach(&mixer, channel, samples, looping);
    // rust: });
    // rust: return;
}
    // rust: let key = format!("{namespace}:{path}");
    // rust: let cached = self.cache.lock().ok().and_then(|mut c| c.get(&key));
    // rust: if let Some(samples) = cached {
    // rust: attach(&self.mixer, channel, samples, looping);
    // rust: return;
}
    // rust: let decoder = self.decoder.get_or_insert_with(|| {
    // rust: let (send, receive) = std::sync::mpsc::channel::<Decode>();
    // rust: let (mixer, cache) = (self.mixer.clone(), self.cache.clone());
    // rust: std::thread::Builder::new()
    // rust: .name("sound decoder".into())
    // rust: .spawn(move || {
    // rust: for job in receive {
                        // Queued twice before the first decode finished.
    // rust: let cached = cache.lock().ok().and_then(|mut c| c.get(&job.key));
    // rust: let samples = cached.unwrap_or_else(|| {
    // rust: let samples = decode(&job.file).map(|(s, r)| (Arc::new(s), r));
    // rust: if let Ok(mut c) = cache.lock() {
    // rust: c.insert(job.key, samples.clone());
}
    // rust: samples
    // rust: });
    // rust: attach(&mixer, job.channel, samples, job.looping);
}
    // rust: })
    // rust: .expect("sound decoder thread");
    // rust: send
    // rust: });
    // rust: let _ = decoder.send(Decode {
    // rust: key,
    // rust: file,
    // rust: channel,
    // rust: looping,
    // rust: });
}
    /// `alSourceStop`: any state becomes stopped, an initial source too (a
    /// sound still decoding then never starts).
pub fn stop(self: *Self, channel: ChannelId) void {
}
    // rust: self.with(channel, |c| c.state = State::Stopped);
}
pub fn pause(self: *Self, channel: ChannelId) void {
}
    // rust: self.with(channel, |c| {
    // rust: if c.state == State::Playing {
    // rust: c.state = State::Paused;
}
    // rust: });
}
pub fn unpause(self: *Self, channel: ChannelId) void {
}
    // rust: self.with(channel, |c| {
    // rust: if c.state == State::Paused {
    // rust: c.state = State::Playing;
}
    // rust: });
}
pub fn stopped(self: *Self, channel: ChannelId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mixer
    // rust: .lock()
    // rust: .map(|m| {
    // rust: m.channels
    // rust: .get(&channel)
    // rust: .is_none_or(|c| c.state == State::Stopped)
    // rust: })
    // rust: .unwrap_or(true)
}
}
/// OpenAL Soft's stereo gains `[left, right]` for a mono source in a
/// direction given in listener space (right, up, forward; any length).
/// Vanilla's context (`Library.createAttributes`: HRTF off) on a stereo
/// output renders pairwise: front azimuths are stretched by 1.5
/// (`ScaleAzimuthFront`, so 60 degrees off-centre pans fully) and the
/// direction is decoded by the first-order stereo decoder, 0.5 W, 0.5 Y and
/// 0.0957 X in this scaling. A centred source gets 0.596 on each side, one
/// behind 0.404, one above or below 0.5, one at the source's own position
/// is panned to the front. Matches OpenAL Soft 1.25.2 (LWJGL 3.4.3, the
/// pinned client's) rendered through `ALC_SOFT_loopback` within 1e-5.
pub fn stereo_gains(right: f32, up: f32, forward: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let length = (right * right + up * up + forward * forward).sqrt();
    // rust: if length <= f32::EPSILON {
    // rust: return stereo_gains(0.0, 0.0, 1.0);
}
    // rust: let elevation = (up / length).clamp(-1.0, 1.0).asin();
    // rust: let mut azimuth = right.atan2(forward);
    // rust: if azimuth.abs() < std::f32::consts::FRAC_PI_2 {
    // rust: azimuth = (azimuth.abs() * 1.5)
    // rust: .min(std::f32::consts::FRAC_PI_2)
    // rust: .copysign(azimuth);
}
    // rust: let side = azimuth.sin() * elevation.cos();
    // rust: let front = azimuth.cos() * elevation.cos() * 0.095_660_8;
    // rust: [0.5 - 0.5 * side + front, 0.5 + 0.5 * side + front]
}
/// The gain OpenAL applies for distance (`AL_LINEAR_DISTANCE` with reference
/// distance 0 and rolloff 1: the distance clamps to the max distance).
pub fn distance_gain(linear: ?f32, distance: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match linear {
    // rust: None => 1.0,
    // rust: Some(max) if max > 0.0 => (1.0 - distance.min(max) / max).clamp(0.0, 1.0),
    // rust: Some(_) => 0.0,
}
}
// Only the output stream mixes; a build without one (no `audio` feature) never does.
pub fn mix(mixer: *mut Mixer, data: *mut [f32], channels: usize, rate: u32) void {
}
    // rust: data.fill(0.0);
    // The camera's forward and up vectors (`Camera.forwardVector`/`upVector`)
    // and OpenAL's right = forward x up.
    // rust: let basis = |yaw: f32, pitch: f32| {
    // rust: let (yaw, pitch) = (f64::from(yaw.to_radians()), f64::from(pitch.to_radians()));
    // rust: let forward = [
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: ];
    // rust: let up = [
    // rust: -yaw.sin() * pitch.sin(),
    // rust: pitch.cos(),
    // rust: yaw.cos() * pitch.sin(),
    // rust: ];
    // rust: let right = [
    // rust: forward[1] * up[2] - forward[2] * up[1],
    // rust: forward[2] * up[0] - forward[0] * up[2],
    // rust: forward[0] * up[1] - forward[1] * up[0],
    // rust: ];
    // rust: (forward, up, right)
}
    // Every camera hearing (splitscreen: the other players' too), in the mixer's own buffer.
    // rust: mixer.cameras.clear();
    // rust: mixer.cameras.extend(
    // rust: std::iter::once((
    // rust: 0,
    // rust: (mixer.listener, mixer.listener_yaw, mixer.listener_pitch),
    // rust: ))
    // rust: .chain(
    // rust: mixer
    // rust: .listeners
    // rust: .iter()
    // rust: .map(|(&owner, &camera)| (owner, camera)),
    // rust: )
    // rust: .map(|(owner, (at, yaw, pitch))| {
    // rust: (
    // rust: at,
    // rust: basis(yaw, pitch),
    // rust: mixer.worlds.get(&owner).copied().unwrap_or_default(),
    // rust: )
    // rust: }),
    // rust: );
    // rust: let shared = mixer.cameras.len() > 1;
    // rust: let dot = |a: [f64; 3], b: [f64; 3]| (a[0] * b[0] + a[1] * b[1] + a[2] * b[2]) as f32;
    // Gains and pans per source for this buffer.
    // rust: let mut voices = std::mem::take(&mut mixer.voices);
    // rust: voices.clear();
    // rust: for (id, c) in &mixer.channels {
    // rust: let Some((_, source_rate)) = &c.samples else {
    // rust: continue;
}
    // rust: if c.state != State::Playing {
    // rust: continue;
}
    // rust: let at = [f64::from(c.at[0]), f64::from(c.at[1]), f64::from(c.at[2])];
    // rust: let away = |listener: [f64; 3]| {
    // rust: [
    // rust: at[0] - listener[0],
    // rust: at[1] - listener[1],
    // rust: at[2] - listener[2],
    // rust: ]
}
    // rust: let length = |d: [f64; 3]| d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
        // The nearest camera hears it (one camera but in splitscreen).
    // rust: let camera = mixer
    // rust: .cameras
    // rust: .iter()
    // rust: .filter(|camera| c.relative || camera.2 == c.world)
    // rust: .min_by(|a, b| length(away(a.0)).total_cmp(&length(away(b.0))))
    // rust: .map(|camera| (camera.0, camera.1));
        // Unheard sources still advance: returning to a world must not resume stale sounds.
    // rust: let (listener, (forward, up, right)) = camera.unwrap_or(([0.0; 3], basis(0.0, 0.0)));
    // rust: let d = if c.relative { at } else { away(listener) };
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt() as f32;
    // rust: let gain = if camera.is_some() {
    // rust: c.gain.clamp(0.0, 1.0) * distance_gain(c.linear, distance)
    // rust: } else {
    // rust: 0.0
}
        // Relative sources are already in OpenAL's listener space (-Z ahead).
    // rust: let [mut left, mut right] = if c.relative {
    // rust: stereo_gains(d[0] as f32, d[1] as f32, -d[2] as f32)
    // rust: } else {
    // rust: stereo_gains(dot(d, right), dot(d, up), dot(d, forward))
}
    // rust: if shared {
            // Several players on the speakers: half the stereo width, as left and right are
            // nobody's in particular.
    // rust: let middle = (left + right) / 2.0;
    // rust: left = middle + (left - middle) / 2.0;
    // rust: right = middle + (right - middle) / 2.0;
}
    // rust: let [left, right] = [left, right].map(|pan| gain * pan);
    // rust: let step = f64::from(*source_rate) / f64::from(rate) * f64::from(c.pitch.max(0.0));
    // rust: voices.push((*id, [left, right, gain], step));
}
    // rust: for (id, [left, right, gain], step) in voices.iter().copied() {
    // rust: let Some(c) = mixer.channels.get_mut(&id) else {
    // rust: continue;
}
    // rust: let Some((samples, _)) = c.samples.clone() else {
    // rust: continue;
}
    // rust: for frame in data.chunks_mut(channels) {
    // rust: let mut i = c.position as usize;
    // rust: if i + 1 >= samples.len() {
    // rust: if c.looping && samples.len() > 1 {
    // rust: c.position = 0.0;
    // rust: i = 0;
    // rust: } else {
    // rust: c.state = State::Stopped;
    // rust: break;
}
}
    // rust: let t = (c.position - i as f64) as f32;
    // rust: let s = samples[i] * (1.0 - t) + samples[i + 1] * t;
    // rust: if channels >= 2 {
    // rust: frame[0] += s * left;
    // rust: frame[1] += s * right;
    // rust: } else {
                // A mono output has no panning: the source's own gain.
    // rust: frame[0] += s * gain;
}
    // rust: c.position += step;
}
}
    // rust: mixer.voices = voices;
    // Limit the whole buffer together, preserving waveform and stereo balance
    // instead of flattening each overloaded sample; release over 200 ms
    // (OpenAL Soft's output limiter, `ALC_OUTPUT_LIMITER_SOFT`, releases
    // over 0.2 s).
    // rust: let peak = data.iter().fold(1.0f32, |peak, s| peak.max(s.abs()));
    // rust: mixer.limiter_peak = mixer.limiter_peak.max(peak);
    // rust: let release = (-1.0 / (0.2 * rate as f32)).exp();
    // rust: for frame in data.chunks_mut(channels) {
    // rust: let gain = mixer.limiter_peak.recip();
    // rust: for s in frame {
    // rust: *s *= gain;
}
    // rust: mixer.limiter_peak = (mixer.limiter_peak * release).max(peak);
}
}
/// Why the game should not open an output, if it should not:
/// `HORIZON_NO_AUDIO`, or a virtual screen (`vscreen`), where agents and
/// harnesses run the game and must stay off the user's speakers.
/// `HORIZON_AUDIO=1` opens the output anyway (testing into a null sink).
pub fn output_disabled(var: impl Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if var("HORIZON_NO_AUDIO").is_some() {
    // rust: return Some("audio off: HORIZON_NO_AUDIO is set".into());
}
    // rust: if var("HORIZON_AUDIO").is_some_and(|v| v == "1") {
    // rust: return None;
}
    // rust: let display = var("WAYLAND_DISPLAY")?;
    // rust: Path::new(&display)
    // rust: .components()
    // rust: .any(|c| c.as_os_str() == "vscreen")
    // rust: .then(|| "audio off on a virtual screen (vscreen); HORIZON_AUDIO=1 opens it".into())
}
/// An output stream on `device` in its default configuration, whatever its
/// sample format: the mixer works in f32 and converts.
    // rust: fn open_device(
    // rust: device: &cpal::Device,
    // rust: mixer: Arc<Mutex<Mixer>>,
    // rust: ) -> Result<(cpal::Stream, cpal::SupportedStreamConfig)> {
//     use cpal::SampleFormat as F;
    // rust: let config = device.default_output_config()?;
    // rust: let build = |stream_config: &cpal::StreamConfig| match config.sample_format() {
    // rust: F::F32 => build_stream::<f32>(device, &config, stream_config, mixer.clone()),
    // rust: F::F64 => build_stream::<f64>(device, &config, stream_config, mixer.clone()),
    // rust: F::I16 => build_stream::<i16>(device, &config, stream_config, mixer.clone()),
    // rust: F::I32 => build_stream::<i32>(device, &config, stream_config, mixer.clone()),
    // rust: F::I8 => build_stream::<i8>(device, &config, stream_config, mixer.clone()),
    // rust: F::U16 => build_stream::<u16>(device, &config, stream_config, mixer.clone()),
    // rust: F::U32 => build_stream::<u32>(device, &config, stream_config, mixer.clone()),
    // rust: F::U8 => build_stream::<u8>(device, &config, stream_config, mixer.clone()),
    // rust: other => Err(format!("unsupported sample format {other}").into()),
}
    // rust: let short = audio_stream_config(&config);
    // rust: let stream = match build(&short) {
    // rust: Ok(stream) => stream,
        // A device that refuses the short fixed buffer still plays with cpal's default one.
    // rust: Err(e) if short != config.config() => {
    // rust: log::info!("Horizon: audio output refused a short buffer ({e}); using the default");
    // rust: build(&config.config())?
}
    // rust: Err(e) => return Err(e),
}
    // rust: stream.play()?;
    // rust: if let Ok(mut m) = mixer.lock() {
    // rust: m.device_name = device.name().unwrap_or_default();
    // rust: m.device_lost = false;
}
    // rust: Ok((stream, config))
}
/// Try one output device for `open`: skip it when it was already tried, log it
/// when it opens, and keep its error when it does not.
    // rust: fn try_open_device(
    // rust: device: &cpal::Device,
    // rust: mixer: Arc<Mutex<Mixer>>,
    // rust: tried: &mut Vec<String>,
    // rust: errors: &mut Vec<String>,
    // rust: ) -> Option<cpal::Stream> {
    // rust: let name = device.name().unwrap_or_else(|_| "unnamed device".into());
    // rust: if tried.contains(&name) {
    // rust: return None;
}
    // rust: tried.push(name.clone());
    // rust: match open_device(device, mixer) {
    // rust: Ok((stream, config)) => {
    // rust: log::info!(
    // rust: "Horizon: audio output {name} ({} Hz, {} channels, {})",
    // rust: config.sample_rate().0,
    // rust: config.channels(),
    // rust: config.sample_format()
    // rust: );
    // rust: Some(stream)
}
    // rust: Err(e) => {
    // rust: errors.push(format!("{name}: {e}"));
    // rust: None
}
}
}
/// The name of the system's default output device.
pub fn default_output_name() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cpal::default_host()
    // rust: .default_output_device()
    // rust: .and_then(|d| d.name().ok())
}
/// A cheap fingerprint of what `output_devices` can list. On Linux, the ALSA
/// cards: the rest are `cpal`'s fixed names. On macOS, every Core Audio
/// device's name, inputs included: telling which of them play opens each one
/// (about 90 ms a second with twenty devices), naming them takes 2 or 3 ms.
/// `None` elsewhere, where the list is always looked at.
pub fn card_fingerprint() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
    // rust: std::fs::read_to_string("/proc/asound/cards").ok()
}
    // rust: {
    // rust: let devices = cpal::default_host().devices().ok()?;
    // rust: Some(
    // rust: devices
    // rust: .filter_map(|d| d.name().ok())
    // rust: .collect::<Vec<_>>()
    // rust: .join("\n"),
    // rust: )
}
    // rust: {
    // rust: None
}
}
/// Whether the output device list should be looked at again: only the ALSA
/// cards can add or remove an entry, and `None` means there is no fingerprint,
/// so the list has to be checked as before.
pub fn cards_changed(seen: ?[]const u8, cards: ?[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (seen, cards) {
    // rust: (Some(seen), Some(cards)) => seen != cards,
    // rust: _ => true,
}
}

/// The cpal `StreamConfig` to open an output stream with. On Linux the ALSA
/// backend's `BufferSize::Default` means a ~100 ms buffer, so sound effects
/// come out about 100 ms late: request a short fixed buffer there. Other
/// platforms keep cpal's default behaviour.
pub fn audio_stream_config(config: *cpal::SupportedStreamConfig) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
    // rust: let range = match config.buffer_size() {
    // rust: cpal::SupportedBufferSize::Range { min, max } => (*min, *max),
    // rust: cpal::SupportedBufferSize::Unknown => (256, 4096),
}
    // rust: let target = 1024u32.clamp(range.0, range.1);
    // rust: let mut sc = config.config();
    // rust: sc.buffer_size = cpal::BufferSize::Fixed(target);
    // rust: sc
}
    // rust: {
    // rust: config.config()
}
}

    // rust: fn build_stream<T: cpal::SizedSample + cpal::FromSample<f32>>(
    // rust: device: &cpal::Device,
    // rust: config: &cpal::SupportedStreamConfig,
    // rust: stream_config: &cpal::StreamConfig,
    // rust: mixer: Arc<Mutex<Mixer>>,
    // rust: ) -> Result<cpal::Stream> {
    // rust: let rate = config.sample_rate().0;
    // rust: let channels = config.channels() as usize;
    // rust: let mut scratch = Vec::new();
    // rust: let on_error = mixer.clone();
    // rust: let stream = device.build_output_stream(
    // rust: stream_config,
    // rust: move |data: &mut [T], _| {
    // rust: scratch.resize(data.len(), 0.0f32);
    // rust: if let Ok(mut m) = mixer.lock() {
    // rust: mix(&mut m, &mut scratch, channels, rate);
    // rust: } else {
    // rust: scratch.fill(0.0);
}
    // rust: for (out, s) in data.iter_mut().zip(&scratch) {
    // rust: *out = T::from_sample(*s);
}
    // rust: },
    // rust: move |e| {
    // rust: log::warn!("Horizon: audio stream error: {e}");
    // rust: if matches!(e, cpal::StreamError::DeviceNotAvailable)
    // rust: && let Ok(mut m) = on_error.lock()
    // rust: {
    // rust: m.device_lost = true;
}
    // rust: },
    // rust: None,
    // rust: )?;
    // rust: Ok(stream)
}
/// Available audio output device names.
pub fn output_devices() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if output_disabled(|name| std::env::var_os(name)).is_some() {
    // rust: return Vec::new();
}
    // rust: let host = cpal::default_host();
    // rust: let mut names = Vec::new();
    // rust: if let Ok(devices) = host.output_devices() {
    // rust: for device in devices {
    // rust: if let Ok(name) = device.name()
    // rust: && !names.contains(&name)
    // rust: {
    // rust: names.push(name);
}
}
}
    // rust: names
}

pub fn output_devices() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec::new()
}

    // rust: impl Audio {
pub fn new(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_device(root, "")
}
pub fn with_device(root: *Path, device_name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_output(root, true, device_name)
}
    /// No output device: the dedicated server.
pub fn silent(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_output(root, false, "")
}
    /// The output device asked for (`soundDevice`), empty for the system's default; the
    /// default plays when that one can't be opened, as in vanilla.
pub fn device(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.device_name
}
pub fn with_output(root: *Path, output: bool, target_device: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = SoundRegistry::load(root);
    // rust: if output && registry.is_empty() {
            // The game then plays nothing on a working output (#1035, #1076).
    // rust: log::warn!(
    // rust: "Horizon: no sounds in {}: they were not copied from your Minecraft \
    // rust: install; prepare the game again in the launcher (or run \
    // rust: horizon-prepare sounds)",
    // rust: root.join("assets").display()
    // rust: );
}
    // rust: let mixer = Arc::new(Mutex::new(Mixer::default()));
    // rust: let opened = if output {
    // rust: Self::open_named(mixer.clone(), target_device)
    // rust: } else {
    // rust: Err("no output on a dedicated server".into())
}
    // rust: let (stream, live) = match opened {
    // rust: Ok(v) => (Some(v), true),
    // rust: Err(e) => {
    // rust: if output {
    // rust: log::warn!("Horizon: no sound: {e}");
}
    // rust: (None, false)
}
}
    // rust: let mut engine = SoundEngine::new(registry);
    // rust: engine.loaded = live;
    // rust: let cards = if live { card_fingerprint() } else { None };
        // Where the cards gate the list (Linux, macOS), it starts empty: opening the
        // output does not need it, and listing it probes every device; the first
        // change fills it. Elsewhere it starts with every device listed, as before.
    // rust: let devices = if live && cards.is_none() {
    // rust: output_devices()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: Self {
    // rust: _stream: stream,
    // rust: device_name: target_device.to_owned(),
    // rust: engine,
    // rust: backend: MixerBackend {
    // rust: mixer,
    // rust: root: root.to_owned(),
    // rust: cache: Arc::default(),
    // rust: decoder: None,
    // rust: next: 0,
    // rust: live,
    // rust: owner: 0,
    // rust: world: 0,
    // rust: shares: Arc::default(),
    // rust: },
    // rust: record_heard: false,
    // rust: listener: [0.0; 3],
    // rust: listener_yaw: 0.0,
    // rust: master: 1.0,
    // rust: random: LegacyRandom::new(crate::sound_engine::unique_seed()),
    // rust: source_override: None,
    // rust: capture: None,
    // rust: heard: Default::default(),
    // rust: stopped: Default::default(),
    // rust: preview: Default::default(),
    // rust: default_seen: if live { default_output_name() } else { None },
    // rust: cards_seen: cards,
    // rust: devices_seen: devices,
    // rust: device_ticks: 0,
}
}
pub fn open_named(_: *Mutex<Mixer>, _: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err("this build has no sound output (built without the `audio` feature)".into())
}
pub fn open_named(mixer: *Mutex<Mixer>, target: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(reason) = output_disabled(|name| std::env::var_os(name)) {
    // rust: return Err(reason.into());
}
    // rust: let host = cpal::default_host();
    // rust: if !target.is_empty()
    // rust: && let Ok(devices) = host.output_devices()
    // rust: {
    // rust: for device in devices {
    // rust: let name = device.name().unwrap_or_else(|_| "unnamed device".into());
    // rust: if name == target {
    // rust: match open_device(&device, mixer.clone()) {
    // rust: Ok((stream, config)) => {
    // rust: log::info!(
    // rust: "Horizon: audio output {name} ({} Hz, {} channels, {})",
    // rust: config.sample_rate().0,
    // rust: config.channels(),
    // rust: config.sample_format()
    // rust: );
    // rust: return Ok(stream);
}
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Horizon: could not open audio device '{target}': {e}; falling back to default"
    // rust: );
}
}
    // rust: break;
}
}
}
    // rust: Self::open(mixer)
}
pub fn set_device(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.backend.live && self._stream.is_none() && !self.engine.loaded {
    // rust: self.device_name = name.to_owned();
    // rust: return Ok(());
}
    // rust: self._stream = Some(Self::open_named(self.backend.mixer.clone(), name)?);
    // rust: self.device_name = name.to_owned();
    // rust: self.backend.live = true;
    // rust: self.engine.loaded = true;
    // rust: Ok(())
}
pub fn set_device(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.device_name = name.to_owned();
    // rust: Ok(())
}
pub fn open(mixer: *Mutex<Mixer>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(reason) = output_disabled(|name| std::env::var_os(name)) {
    // rust: return Err(reason.into());
}
    // rust: let host = cpal::default_host();
    // rust: let mut errors = Vec::new();
        // The default device first: it is what plays, and listing the others
        // probes every PCM, which is slow and prints ALSA's errors for the
        // plugins this system lacks.
    // rust: let mut tried = Vec::new();
    // rust: if let Some(device) = host.default_output_device()
    // rust: && let Some(stream) = try_open_device(&device, mixer.clone(), &mut tried, &mut errors)
    // rust: {
    // rust: return Ok(stream);
}
        // A default that cannot open (busy, or a stale ALSA default) should not
        // leave the game silent when another device works.
    // rust: for device in host.output_devices().into_iter().flatten() {
    // rust: if let Some(stream) = try_open_device(&device, mixer.clone(), &mut tried, &mut errors) {
    // rust: return Ok(stream);
}
}
    // rust: if errors.is_empty() {
    // rust: return Err(format!("no audio output device on the {} host", host.id().name()).into());
}
    // rust: Err(format!("no audio output device opened ({})", errors.join("; ")).into())
}
pub fn bound(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Bound {
    // rust: engine: &mut self.engine,
    // rust: backend: &mut self.backend,
}
}
    /// World identity for this player's sources and camera. Existing channels keep their world.
pub fn set_world(self: *Self, world: []const u8) void {
}
    // rust: if let Ok(mut mixer) = self.backend.mixer.lock() {
    // rust: let id = mixer.world_id(world);
    // rust: self.backend.world = id;
    // rust: mixer.worlds.insert(self.backend.owner, id);
}
}

    /// `SoundManager.updateSource`: the camera position and rotation
    /// (`Listener.setTransform` takes its forward and up vectors).
pub fn set_listener(self: *Self, position: [f64; 3], yaw: f32, pitch: f32) void {
}
    // rust: self.listener = position;
    // rust: self.listener_yaw = yaw;
    // rust: if let Ok(mut m) = self.backend.mixer.lock() {
    // rust: if self.backend.owner == 0 {
    // rust: m.listener = position;
    // rust: m.listener_yaw = yaw;
    // rust: m.listener_pitch = pitch;
    // rust: } else {
    // rust: m.listeners
    // rust: .insert(self.backend.owner, (position, yaw, pitch));
}
}
}
    /// Splitscreen: another player's sounds on this output, heard from its camera too
    /// (`owner`: 1 to 255, its own). Dropped, its camera and sounds go.
pub fn share(self: *Self, owner: u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert_ne!(owner, 0, "shared audio owners must be nonzero");
    // rust: self.backend
    // rust: .shares
    // rust: .fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let mut engine = SoundEngine::new(self.engine.registry.clone());
    // rust: engine.loaded = self.backend.live;
    // rust: Self {
    // rust: _stream: None,
    // rust: device_name: self.device_name.clone(),
    // rust: engine,
    // rust: backend: MixerBackend {
    // rust: mixer: self.backend.mixer.clone(),
    // rust: root: self.backend.root.clone(),
    // rust: cache: self.backend.cache.clone(),
    // rust: decoder: None,
    // rust: next: (SHARED_CHANNELS.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1)
    // rust: << 40,
    // rust: live: self.backend.live,
    // rust: owner,
    // rust: world: self.backend.world,
    // rust: shares: self.backend.shares.clone(),
    // rust: },
    // rust: record_heard: false,
    // rust: listener: [0.0; 3],
    // rust: listener_yaw: 0.0,
    // rust: master: self.master,
    // rust: random: LegacyRandom::new(crate::sound_engine::unique_seed()),
    // rust: source_override: None,
    // rust: capture: None,
    // rust: heard: Default::default(),
    // rust: stopped: Default::default(),
    // rust: preview: Default::default(),
            // The device belongs to the first player's output, which looks after it.
    // rust: default_seen: self.default_seen.clone(),
    // rust: cards_seen: self.cards_seen.clone(),
    // rust: devices_seen: self.devices_seen.clone(),
    // rust: device_ticks: 0,
}
}
    /// Sync the volume options, refreshing the categories that changed
    /// (the option sliders' `refreshCategoryVolume`).
pub fn sync_volumes(self: *Self) void {
}
    // rust: let mut volumes = [self.master; 11];
    // rust: for (i, v) in volumes.iter_mut().enumerate().skip(1) {
    // rust: *v = crate::settings::source_volume(i);
}
    // rust: for source in 0..11 {
    // rust: if self.engine.source_volumes[source] != volumes[source] {
    // rust: self.engine.source_volumes[source] = volumes[source];
    // rust: self.engine
    // rust: .refresh_category_volume(source, &mut self.backend);
}
}
    // rust: self.engine.listening = self.record_heard;
}
    /// `SoundEngine.shouldChangeDevice`: the open device was lost, the system
    /// default changed (with no device chosen in the options), or the chosen
    /// device came back; the output is then opened again. The devices are looked
    /// at once a second.
pub fn should_change_device(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
        // A splitscreen share plays through the first player's output: it leaves the device,
        // and the mixer's lost flag, to that output.
    // rust: if self.backend.owner != 0 {
    // rust: return false;
}
    // rust: let (current, lost) = match self.backend.mixer.lock() {
    // rust: Ok(mut m) => (m.device_name.clone(), std::mem::take(&mut m.device_lost)),
    // rust: Err(_) => return false,
}
    // rust: if lost {
    // rust: log::info!("Horizon: audio device was lost");
    // rust: self.default_seen = default_output_name();
    // rust: self.cards_seen = card_fingerprint();
    // rust: self.devices_seen = output_devices();
    // rust: return true;
}
    // rust: self.device_ticks += 1;
    // rust: if self._stream.is_none() || self.device_ticks < 20 {
    // rust: return false;
}
    // rust: self.device_ticks = 0;
    // rust: let default = default_output_name();
    // rust: let cards = card_fingerprint();
        // Listing the devices probes every one (on Linux every built-in PCM,
        // printing ALSA's errors for the plugins this system lacks; on macOS
        // every Core Audio device, about 90 ms with twenty of them); only the
        // fingerprint's devices can change the list, and it is cheap.
    // rust: if default == self.default_seen
    // rust: && !cards_changed(self.cards_seen.as_deref(), cards.as_deref())
    // rust: {
    // rust: return false;
}
    // rust: self.cards_seen = cards;
    // rust: let devices = output_devices();
        // Only a change in the device lists is looked at, as in vanilla: a
        // preferred device that is listed but cannot open is not retried.
    // rust: if default == self.default_seen && devices == self.devices_seen {
    // rust: return false;
}
    // rust: self.default_seen = default.clone();
    // rust: let wanted = self.device_name.clone();
    // rust: let available = devices.contains(&wanted);
    // rust: self.devices_seen = devices;
    // rust: if wanted.is_empty() {
    // rust: let changed = default.as_deref().is_some_and(|d| d != current);
    // rust: if changed {
    // rust: log::info!("Horizon: system default audio device has changed");
}
    // rust: return changed;
}
    // rust: let changed = current != wanted && available;
    // rust: if changed {
    // rust: log::info!("Horizon: preferred audio device has become available");
}
    // rust: changed
}
    /// `SoundManager.tick(paused)`, once per client tick.
pub fn tick(self: *Self, paused: bool, ctx: *TickContext) void {
}
    // rust: {
    // rust: if self.should_change_device() {
                // SoundEngine.reload: stop every sound, open the output again.
    // rust: self.stop_all();
    // rust: let device = self.device_name.clone();
    // rust: if let Err(e) = self.set_device(&device) {
    // rust: log::warn!("Horizon: could not reopen the audio output: {e}");
}
}
}
    // rust: self.sync_volumes();
    // rust: self.engine.tick(paused, ctx, &mut self.backend);
}
    /// The `uiSoundReserve` extra: positional sounds leave
    /// `sound_engine::HEARD_RESERVE` static channels free (off: vanilla's pool).
pub fn set_listener_reserve(self: *Self, on: bool) void {
}
    // rust: self.engine.listener_reserve = if on {
    // rust: crate::sound_engine::HEARD_RESERVE
    // rust: } else {
    // rust: 0
}
}
    /// `SoundManager.pauseAllExcept(MUSIC, UI)`.
pub fn pause(self: *Self) void {
}
    // rust: self.engine.pause_all_except(
    // rust: &[crate::sound_engine::MUSIC, crate::sound_engine::UI],
    // rust: &mut self.backend,
    // rust: );
}
    /// `SoundManager.resume`.
pub fn resume(self: *Self) void {
}
    // rust: self.engine.resume(&mut self.backend);
}
    /// `SoundManager.stop()`: every sound.
pub fn stop_all(self: *Self) void {
}
    // rust: self.engine.stop_all(&mut self.backend);
}
    /// `SoundManager.reload` (resource packs changed): stop every sound, then
    /// read sound events and sound files from the new resource root.
pub fn reload(self: *Self, root: *Path) void {
}
    // rust: self.reload_with(root, SoundRegistry::load(root));
}
    /// [`Self::reload`] with the root's sound events already read
    /// (`SoundRegistry::load`, which a pack reload runs off the render thread).
pub fn reload_with(self: *Self, root: *Path, registry: SoundRegistry) void {
}
    // rust: self.stop_all();
    // rust: self.engine.registry = registry;
    // rust: self.backend.root = root.to_owned();
    // rust: let mut cache = self.backend.cache.lock().unwrap();
    // rust: cache.entries.clear();
    // rust: cache.bytes = 0;
}
    /// Play a sound event at a world position, as `ClientLevel.playLocalSound`
    /// (a `SimpleSoundInstance` seeded from the level random), or relative to
    /// the listener without attenuation (`None`).
pub fn play(self: *Self, event: []const u8, at: ?[f64; 3], volume: f32, pitch: f32) void {
}
    // rust: let seed = self.random.next_long();
    // rust: self.play_seeded(event, at, volume, pitch, seed);
}
    /// `ClientLevel.playLocalSound` with `distanceDelay`: a sound more than 10
    /// blocks from the camera starts `sqrt(distance) / 40` seconds later.
    // rust: pub fn play_distance_delayed(
    // rust: &mut self,
    // rust: event: &str,
    // rust: at: [f64; 3],
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: camera: [f64; 3],
    // rust: ) {
    // rust: let distance_sqr: f64 = (0..3).map(|i| (at[i] - camera[i]).powi(2)).sum();
    // rust: if distance_sqr <= 100.0 {
    // rust: self.play(event, Some(at), volume, pitch);
    // rust: return;
}
    // rust: self.play_after(
    // rust: event,
    // rust: at,
    // rust: volume,
    // rust: pitch,
    // rust: (distance_sqr.sqrt() / 40.0 * 20.0) as i32,
    // rust: );
}
    /// `play` at a world position, starting `ticks` sound-engine ticks (20 a
    /// second) from now: `SoundEngine.playDelayed`.
pub fn play_after(self: *Self, event: []const u8, at: [f64; 3], volume: f32, pitch: f32, ticks: i32) void {
}
    // rust: let seed = self.random.next_long();
    // rust: if let Some(capture) = self.capture.as_mut() {
    // rust: capture.push(CapturedSound {
    // rust: event: event.to_owned(),
    // rust: position: at,
    // rust: volume,
    // rust: pitch,
    // rust: source: self.source_override.unwrap_or_else(|| {
    // rust: crate::settings::sound_source(&crate::sound_events::normalize(event))
    // rust: }),
    // rust: entity: None,
    // rust: except_entity: None,
    // rust: });
}
    // rust: *self.heard.entry(event.to_owned()).or_default() += 1;
    // rust: self.sync_volumes();
    // rust: let event = crate::sound_events::normalize(event);
    // rust: let source = self
    // rust: .source_override
    // rust: .unwrap_or_else(|| crate::settings::sound_source(&event));
    // rust: let instance =
    // rust: SoundInstance::at(&event, source, volume, pitch, LegacyRandom::new(seed), at);
    // rust: let id = self.engine.add(instance, false);
    // rust: self.engine.play_delayed(id, ticks);
}
    /// `play` for this client only: a sound a packet's handler plays
    /// (`playLocalSound`), which the guests play from that packet themselves.
pub fn play_unshared(self: *Self, event: []const u8, at: ?[f64; 3], volume: f32, pitch: f32) void {
}
    // rust: let capture = self.capture.take();
    // rust: self.play(event, at, volume, pitch);
    // rust: self.capture = capture;
}
    /// `AbstractWidget.playButtonClickSound`: an unseeded, relative UI sound.
pub fn play_button_click(self: *Self) void {
}
    // rust: self.play_instance(
    // rust: SoundInstance::for_ui(
    // rust: "minecraft:ui.button.click",
    // rust: 1.0,
    // rust: 0.25,
    // rust: SoundEngine::unseeded(),
    // rust: ),
    // rust: false,
    // rust: );
}
    /// `SoundPreviewHandler.preview`: a category volume slider moved to
    /// `volume` on the title screen's options.
pub fn preview(self: *Self, source: usize, volume: f32) void {
}
    // rust: let mut preview = std::mem::take(&mut self.preview);
    // rust: preview.preview(self, source, volume);
    // rust: self.preview = preview;
}
    /// An incoming entity-sound packet: retain its seed and category without rebroadcasting it.
    // rust: pub fn play_entity_seeded(
    // rust: &mut self,
    // rust: event: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: seed: i64,
    // rust: entity: crate::sound_engine::SoundEntity,
    // rust: ) {
    // rust: *self.heard.entry(event.to_owned()).or_default() += 1;
    // rust: let event = crate::sound_events::normalize(event);
    // rust: let instance = SoundInstance::entity_bound(
    // rust: &event,
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: LegacyRandom::new(seed),
    // rust: entity,
    // rust: );
    // rust: self.play_instance(instance, false);
}
    /// A level's entity overload: preserve the emitter and excluded player for
    /// the server broadcaster while the local sound follows the same object.
    // rust: pub fn play_bound(
    // rust: &mut self,
    // rust: event: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: entity: crate::sound_engine::SoundEntity,
    // rust: except_entity: Option<u32>,
    // rust: ) {
    // rust: if let Some(capture) = self.capture.as_mut() {
    // rust: capture.push(CapturedSound {
    // rust: event: event.to_owned(),
    // rust: position: entity.state().position,
    // rust: volume,
    // rust: pitch,
    // rust: source,
    // rust: entity: Some(entity.id),
    // rust: except_entity,
    // rust: });
}
    // rust: let seed = self.random.next_long();
    // rust: self.play_entity_seeded(event, source, volume, pitch, seed, entity);
}
    /// Removal belongs to the old object even if its numeric id is immediately reused.
pub fn remove_sound_entity(self: *Self, id: u32) void {
}
    // rust: for entity in self
    // rust: .engine
    // rust: .bound_entities()
    // rust: .into_iter()
    // rust: .filter(|e| e.id == id)
    // rust: {
    // rust: let mut state = entity.state();
    // rust: state.removed = true;
    // rust: entity.update(state);
}
}
    /// `play` with the seed a sound packet carries.
    // rust: pub fn play_seeded(
    // rust: &mut self,
    // rust: event: &str,
    // rust: at: Option<[f64; 3]>,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: seed: i64,
    // rust: ) {
    // rust: if let (Some(capture), Some(at)) = (self.capture.as_mut(), at) {
    // rust: capture.push(CapturedSound {
    // rust: event: event.to_owned(),
    // rust: position: at,
    // rust: volume,
    // rust: pitch,
    // rust: source: self.source_override.unwrap_or_else(|| {
    // rust: crate::settings::sound_source(&crate::sound_events::normalize(event))
    // rust: }),
    // rust: entity: None,
    // rust: except_entity: None,
    // rust: });
}
    // rust: if at.is_some() {
    // rust: *self.heard.entry(event.to_owned()).or_default() += 1;
}
    // rust: self.sync_volumes();
    // rust: let event = crate::sound_events::normalize(event);
    // rust: let source = self
    // rust: .source_override
    // rust: .unwrap_or_else(|| crate::settings::sound_source(&event));
    // rust: let random = LegacyRandom::new(seed);
    // rust: let instance = match at {
    // rust: Some(at) => SoundInstance::at(&event, source, volume, pitch, random, at),
    // rust: None => SoundInstance::new(
    // rust: &event,
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: ),
}
    // rust: self.play_instance(instance, false);
}
    /// Play a sound on a given `SoundSource` index (`/playsound`).
    // rust: pub fn play_on(
    // rust: &mut self,
    // rust: source: usize,
    // rust: event: &str,
    // rust: at: Option<[f64; 3]>,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) {
    // rust: self.source_override = Some(source);
    // rust: self.play(event, at, volume, pitch);
    // rust: self.source_override = None;
}
    /// `SimpleSoundInstance.forJukeboxSong` at a jukebox; the handle stays
    /// until `release`.
pub fn play_jukebox_song(self: *Self, event: []const u8, pos: [i32; 3]) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let event = crate::sound_events::normalize(event);
    // rust: let instance = SoundInstance::for_jukebox_song(&event, at, SoundEngine::unseeded());
    // rust: self.play_instance(instance, true).0
}
    /// Stop and drop a held instance.
pub fn stop_and_release(self: *Self, id: InstanceId) void {
}
    // rust: self.stop_instance(id);
    // rust: self.release(id);
}
    /// `SoundBufferLibrary.enumerate`: the decoded buffers kept and their bytes.
pub fn cache_stats(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.backend
    // rust: .cache
    // rust: .lock()
    // rust: .map_or((0, 0), |c| (c.entries.len(), c.bytes))
}
    /// Every sound event id (for command completion).
    /// The engine's table sizes and the mixer's channels (`status`).
pub fn census(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut census = self.engine.census();
    // rust: census["channels"] = self
    // rust: .backend
    // rust: .mixer
    // rust: .lock()
    // rust: .map_or(0, |m| m.channels.len())
    // rust: .into();
    // rust: if let Ok(cache) = self.backend.cache.lock() {
    // rust: census["decoded"] = cache.entries.len().into();
    // rust: census["decoded_mib"] = (cache.bytes >> 20).into();
}
    // rust: census
}
pub fn event_names(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v: Vec<String> = self.engine.registry.names().cloned().collect();
    // rust: v.sort();
    // rust: v
}
    /// `ClientboundStopSoundPacket`: stop the playing sounds of an event
    /// and/or a source.
pub fn stop_sounds(self: *Self, event: ?[]const u8, source: ?usize) void {
}
    // rust: let event = event.map(crate::sound_events::normalize);
    // rust: let selection = format!(
    // rust: "{} {}",
    // rust: source
    // rust: .and_then(|s| crate::settings::SOUND_SOURCES.get(s))
    // rust: .map_or("*", |s| s),
    // rust: event.as_deref().unwrap_or("*")
    // rust: );
    // rust: *self.stopped.entry(selection).or_default() += 1;
    // rust: self.engine
    // rust: .stop_matching(event.as_deref(), source, &mut self.backend);
}
    /// The sounds played since the last call, for the subtitle overlay.
pub fn take_heard(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.engine.notifications)
    // rust: .into_iter()
    // rust: .filter_map(|n| {
    // rust: Some(Heard {
    // rust: subtitle: n.subtitle?,
    // rust: at: Some(n.position),
    // rust: range: n.range,
    // rust: looping: n.looping,
    // rust: })
    // rust: })
    // rust: .collect()
}
}
    // rust: impl Sounds for Audio {
pub fn engine(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.engine
}
pub fn play_instance(self: *Self, instance: SoundInstance, retain: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync_volumes();
    // rust: self.bound().play_instance(instance, retain)
}
pub fn play_id(self: *Self, id: InstanceId) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync_volumes();
    // rust: self.bound().play_id(id)
}
pub fn stop_instance(self: *Self, id: InstanceId) void {
}
    // rust: self.bound().stop_instance(id);
}
pub fn update_category_volume(self: *Self, source: usize, gain: f32) void {
}
    // rust: self.bound().update_category_volume(source, gain);
}
}

    // rust: mod tests {
//     use super::*;

pub fn level_capture_keeps_order_category_entity_and_actor_exclusion() void {
}
    // rust: let mut audio = Audio::silent(Path::new("/nonexistent/horizon-entity-sound-test"));
    // rust: audio.capture = Some(Vec::new());
    // rust: let mut expected = audio.random.clone();
    // rust: audio.play_on(
    // rust: 7,
    // rust: "minecraft:block.amethyst_block.chime",
    // rust: Some([1.0; 3]),
    // rust: 0.5,
    // rust: 1.0,
    // rust: );
    // rust: let entity = crate::sound_engine::SoundEntity::new(37, [2.123456789, 64.0, -3.0], false);
    // rust: audio.play_bound(
    // rust: "minecraft:block.amethyst_block.chime",
    // rust: 6,
    // rust: 2.0,
    // rust: 1.2,
    // rust: entity,
    // rust: Some(17),
    // rust: );
    // rust: let sounds = audio.capture.as_ref().unwrap();
    // rust: assert_eq!(sounds.len(), 2);
    // rust: assert_eq!(
    // rust: (sounds[0].source, sounds[0].entity, sounds[0].except_entity),
    // rust: (7, None, None)
    // rust: );
    // rust: let bound = &sounds[1];
    // rust: assert_eq!(
    // rust: (bound.source, bound.entity, bound.except_entity),
    // rust: (6, Some(37), Some(17))
    // rust: );
    // rust: assert_eq!(bound.position, [2.123456789, 64.0, -3.0]);
    // rust: assert_eq!((bound.volume, bound.pitch), (2.0, 1.2));
    // rust: expected.next_long();
    // rust: expected.next_long();
    // rust: assert_eq!(audio.random.next_long(), expected.next_long());
}

pub fn entity_sound_packets_neither_rebroadcast_nor_advance_the_local_seed_generator() void {
}
    // rust: let mut audio = Audio::silent(Path::new("/nonexistent/horizon-entity-sound-test"));
    // rust: audio.capture = Some(Vec::new());
    // rust: let mut expected = audio.random.clone();
    // rust: let entity = crate::sound_engine::SoundEntity::new(7, [1.0, 2.0, 3.0], false);
    // rust: audio.play_entity_seeded("minecraft:fixture.bound", 6, 0.7, 1.2, 42, entity);
    // rust: assert!(audio.capture.as_ref().unwrap().is_empty());
    // rust: assert_eq!(audio.random.next_long(), expected.next_long());
}
pub fn removal_marks_only_existing_references_to_that_entity() void {
}
//         use crate::sound_engine::SoundEntity;
    // rust: let mut audio = Audio::silent(Path::new("/nonexistent/horizon-entity-sound-test"));
    // rust: let old = SoundEntity::new(7, [0.0; 3], false);
    // rust: let other = SoundEntity::new(8, [0.0; 3], false);
    // rust: for entity in [old.clone(), other.clone()] {
    // rust: audio.engine.add(
    // rust: SoundInstance::entity_bound(
    // rust: "minecraft:fixture.bound",
    // rust: 6,
    // rust: 1.0,
    // rust: 1.0,
    // rust: LegacyRandom::new(42),
    // rust: entity,
    // rust: ),
    // rust: true,
    // rust: );
}
    // rust: audio.remove_sound_entity(7);
    // rust: let replacement = SoundEntity::new(7, [10.0; 3], false);
    // rust: assert!(old.state().removed);
    // rust: assert!(!other.state().removed);
    // rust: assert!(!replacement.state().removed);
}

pub fn button_click_uses_vanilla_ui_parameters_without_advancing_world_random() void {
}
    // rust: let mut audio = Audio::silent(Path::new("/nonexistent/horizon-test-assets"));
    // rust: audio.engine.registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"ui.button.click":{"sounds":["gui/button"]}}"#,
    // rust: &|_, _| true,
    // rust: );
        // Exercise the mixer without opening an output device. The missing
        // sample is harmless: this test checks the source the engine creates.
    // rust: audio.engine.loaded = true;
    // rust: audio.backend.live = true;
    // rust: let mut random = audio.random.clone();
    // rust: audio.play_button_click();
    // rust: let instance = audio.engine.instance(1).expect("click reached the engine");
    // rust: assert_eq!(instance.identifier, "minecraft:ui.button.click");
    // rust: assert_eq!(instance.source, crate::sound_engine::UI);
    // rust: assert_eq!(instance.volume, 0.25);
    // rust: assert_eq!(instance.pitch, 1.0);
    // rust: assert_eq!(instance.attenuation, Attenuation::None);
    // rust: assert_eq!(instance.position, [0.0; 3]);
    // rust: assert!(instance.relative);
    // rust: assert!(!instance.looping);
    // rust: assert_eq!(audio.random.next_long(), random.next_long());
    // rust: audio.pause();
    // rust: assert_eq!(
    // rust: audio.backend.mixer.lock().unwrap().channels[&1].state,
    // rust: State::Initial
    // rust: );
    // rust: audio.stop_all();
}

pub fn channel(samples: std.ArrayList(f32), linear: ?f32, at: [f32; 3], looping: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Channel {
    // rust: samples: Some((Arc::new(samples), 48_000)),
    // rust: position: 0.0,
    // rust: state: State::Playing,
    // rust: gain: 1.0,
    // rust: pitch: 1.0,
    // rust: linear,
    // rust: looping,
    // rust: at,
    // rust: relative: false,
    // rust: owner: 0,
    // rust: world: 0,
    // rust: started: None,
}
}

pub fn decoded_sounds_stay_within_the_budget_least_recently_used_out() void {
}
    // rust: let mut cache = SoundCache::default();
    // rust: let quarter = CACHE_BYTES / 4 / std::mem::size_of::<f32>();
    // rust: let sound = || Some((Arc::new(vec![0.0f32; quarter]), 44100));
    // rust: for key in ["a", "b", "c", "d"] {
    // rust: cache.insert(key.into(), sound());
}
    // rust: assert!(cache.get("a").is_some());
    // rust: cache.insert("e".into(), sound());
    // rust: assert!(cache.bytes <= CACHE_BYTES);
    // rust: assert!(
    // rust: cache.get("b").is_none(),
    // rust: "the least recently used goes first"
    // rust: );
    // rust: assert!(cache.get("a").is_some() && cache.get("e").is_some());
        // A failed load is remembered without counting.
    // rust: cache.insert("missing".into(), None);
    // rust: assert_eq!(cache.get("missing"), Some(None));
}
pub fn output_stays_off_on_a_virtual_screen_unless_asked() void {
}
    // rust: let env = |pairs: &'static [(&'static str, &'static str)]| {
    // rust: move |name: &str| {
    // rust: pairs
    // rust: .iter()
    // rust: .find(|(k, _)| *k == name)
    // rust: .map(|(_, v)| std::ffi::OsString::from(*v))
}
}
    // rust: assert!(output_disabled(env(&[("WAYLAND_DISPLAY", "wayland-1")])).is_none());
    // rust: assert!(output_disabled(env(&[])).is_none());
pub const VSCREEN: []const u8 = "/run/user/1000/vscreen/main/wayland-1";
    // rust: assert!(output_disabled(env(&[("WAYLAND_DISPLAY", VSCREEN)])).is_some());
    // rust: assert!(
    // rust: output_disabled(env(&[("WAYLAND_DISPLAY", VSCREEN), ("HORIZON_AUDIO", "1")])).is_none()
    // rust: );
    // rust: assert!(
    // rust: output_disabled(env(&[("HORIZON_NO_AUDIO", "1"), ("HORIZON_AUDIO", "1")])).is_some()
    // rust: );
}
pub fn linear_attenuation_reaches_zero_at_the_max_distance() void {
}
    // rust: assert_eq!(distance_gain(None, 100.0), 1.0);
    // rust: assert_eq!(distance_gain(Some(16.0), 0.0), 1.0);
    // rust: assert_eq!(distance_gain(Some(16.0), 8.0), 0.5);
    // rust: assert_eq!(distance_gain(Some(16.0), 16.0), 0.0);
    // rust: assert_eq!(distance_gain(Some(16.0), 40.0), 0.0);
}

pub fn overlapping_voices_are_limited_without_flattening_or_changing_stereo_balance() void {
}
    // rust: let mut m = Mixer::default();
    // rust: let wave = vec![0.25, 0.5, 0.75, 1.0, -1.0, -0.75, -0.5, -0.25, 0.0];
    // rust: for id in 1..=4 {
    // rust: m.channels
    // rust: .insert(id, channel(wave.clone(), None, [-1.0, 0.0, 0.0], false));
}
    // rust: let mut data = [0.0; 16];
    // rust: mix(&mut m, &mut data, 2, 48_000);
        // West of a listener facing south: fully on the right.
    // rust: for (frame, sample) in data.as_chunks::<2>().0.iter().zip(wave) {
    // rust: assert!(frame[0].abs() < 1e-6, "{frame:?}");
    // rust: assert!((frame[1] - sample).abs() < 1e-6, "{frame:?}");
}
    // rust: assert!(data.iter().all(|s| s.abs() <= 1.0));
}

pub fn limiter_leaves_quiet_audio_alone_and_recovers_across_callbacks() void {
}
    // rust: let mut m = Mixer::default();
    // rust: m.channels
    // rust: .insert(1, channel(vec![0.25; 2], None, [0.0; 3], true));
    // rust: let quiet = 0.25 * stereo_gains(0.0, 0.0, 1.0)[0];
    // rust: let mut data = [0.0; 16];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert_eq!(data, [quiet; 16]);

    // rust: for id in 2..=5 {
    // rust: m.channels
    // rust: .insert(id, channel(vec![1.0; 2], None, [0.0; 3], true));
}
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert!(data.iter().all(|s| s.abs() <= 1.0));
    // rust: m.channels.retain(|&id, _| id == 1);
    // rust: let mut recovery = vec![0.0; 2 * 48_000];
    // rust: mix(&mut m, &mut recovery, 2, 48_000);
    // rust: assert!(recovery[0] > 0.0 && recovery[0] < 0.1);
    // rust: assert!(recovery.windows(2).all(|w| w[1] >= w[0]));
    // rust: assert_eq!(*recovery.last().unwrap(), quiet);
}

pub fn sources_play_attenuated_then_stop_or_loop() void {
}
    // rust: let mut m = Mixer::default();
    // rust: m.channels
    // rust: .insert(1, channel(vec![1.0; 4], Some(16.0), [8.0, 0.0, 0.0], false));
    // rust: m.channels
    // rust: .insert(2, channel(vec![1.0; 4], None, [0.0; 3], true));
    // rust: let mut data = [0.0f32; 16];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert_eq!(m.channels[&1].state, State::Stopped);
    // rust: assert_eq!(m.channels[&2].state, State::Playing);
        // Mono sum of the two at the first frame: the far one is half as loud.
    // rust: let first = data[0] + data[1];
    // rust: assert!(first > 1.4 && first < 3.1, "{first}");
}

pub fn stereo_panning_matches_openal_soft() void {
}
        // OpenAL Soft 1.25.2 (LWJGL 3.4.3's macOS build), stereo loopback
        // device with vanilla's attributes, 1 kHz sine 4 blocks away.
    // rust: let cases = [
    // rust: ((0.0, 0.0, 1.0), [0.5957, 0.5957]),
    // rust: ((-1.0, 0.0, 0.0), [1.0, 0.0]),
    // rust: ((1.0, 0.0, 0.0), [0.0, 1.0]),
    // rust: ((0.0, 0.0, -1.0), [0.4043, 0.4043]),
    // rust: ((0.0, 1.0, 0.0), [0.5, 0.5]),
    // rust: ((0.0, -1.0, 0.0), [0.5, 0.5]),
    // rust: ((-1.0, 0.0, 1.0), [0.9985, 0.0747]),
    // rust: ((-1.0, 0.0, -1.0), [0.7859, 0.0788]),
    // rust: ((0.0, 0.0, 0.0), [0.5957, 0.5957]),
    // rust: ];
    // rust: for ((right, up, forward), expected) in cases {
    // rust: let gains = stereo_gains(right, up, forward);
    // rust: for (g, e) in gains.into_iter().zip(expected) {
    // rust: assert!((g - e).abs() < 1e-4, "{right} {up} {forward}: {gains:?}");
}
}
}

pub fn panning_follows_the_camera_rotation() void {
}
    // rust: let gains = |yaw: f32, pitch: f32, at: [f32; 3]| {
    // rust: let mut m = Mixer {
    // rust: listener_yaw: yaw,
    // rust: listener_pitch: pitch,
    // rust: ..Mixer::default()
}
    // rust: m.channels.insert(1, channel(vec![1.0; 4], None, at, true));
    // rust: let mut data = [0.0; 2];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: data
}
    // rust: let close =
    // rust: |a: [f32; 2], b: [f32; 2]| (a[0] - b[0]).abs() < 1e-4 && (a[1] - b[1]).abs() < 1e-4;
        // Facing south (yaw 0), east is on the left; facing north, on the right.
    // rust: assert!(close(gains(0.0, 0.0, [1.0, 0.0, 0.0]), [1.0, 0.0]));
    // rust: assert!(close(gains(180.0, 0.0, [1.0, 0.0, 0.0]), [0.0, 1.0]));
        // Looking straight down, a source below is ahead and one south is above.
    // rust: assert!(close(gains(0.0, 90.0, [0.0, -1.0, 0.0]), [0.5957, 0.5957]));
    // rust: assert!(close(gains(0.0, 90.0, [0.0, 0.0, 1.0]), [0.5, 0.5]));
}

pub fn splitscreen_sounds_are_heard_from_the_nearest_camera() void {
}
        // P1 far away, a second player beside the source: heard at full gain, centred.
    // rust: let mut m = Mixer {
    // rust: listener: [100.0, 0.0, 0.0],
    // rust: ..Mixer::default()
}
    // rust: m.listeners.insert(1, ([0.0, 0.0, 1.0], 0.0, 0.0));
    // rust: m.channels
    // rust: .insert(1, channel(vec![1.0; 4], Some(16.0), [0.0, 0.0, 2.0], true));
    // rust: let mut data = [0.0; 2];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert!(
    // rust: data[0] > 0.5 && (data[0] - data[1]).abs() < 1e-4,
    // rust: "{data:?}"
    // rust: );
        // Alone, P1 would not hear it: 100 blocks past its 16.
    // rust: m.listeners.clear();
    // rust: let mut data = [0.0; 2];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert_eq!(data, [0.0; 2]);
}

pub fn a_shared_listener_registers_even_in_the_hosts_world() void {
}
    // rust: let mut host = Audio::silent(Path::new("/nonexistent/horizon-test-audio"));
    // rust: host.set_world("minecraft:overworld");
    // rust: let mut guest = host.share(1);
    // rust: guest.set_world("minecraft:overworld");
    // rust: guest.set_listener([1.0, 2.0, 3.0], 0.0, 0.0);
    // rust: let id = guest.backend.create(false).unwrap();
    // rust: let mixer = host.backend.mixer.lock().unwrap();
    // rust: let overworld = mixer
    // rust: .world_names
    // rust: .iter()
    // rust: .position(|w| w == "minecraft:overworld");
    // rust: let overworld = overworld.map(|i| i as u32 + 1);
    // rust: assert_eq!(mixer.worlds.get(&1).copied(), overworld);
    // rust: assert_eq!(Some(mixer.channels[&id].world), overworld);
}

pub fn cameras_in_other_dimensions_cannot_hear_a_source() void {
}
    // rust: let mut m = Mixer {
    // rust: listener: [100.0, 0.0, 0.0],
    // rust: ..Default::default()
}
    // rust: m.listeners.insert(1, ([0.0, 0.0, 1.0], 0.0, 0.0));
    // rust: let nether = m.world_id("nether");
    // rust: m.worlds.insert(1, nether);
    // rust: m.channels
    // rust: .insert(1, channel(vec![1.0; 4], Some(16.0), [0.0, 0.0, 2.0], true));
    // rust: let mut data = [0.0; 2];
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert_eq!(
    // rust: data, [0.0; 2],
    // rust: "nearby Nether camera must not hear Overworld source"
    // rust: );
    // rust: m.channels.get_mut(&1).unwrap().world = nether;
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert!(data[0] > 0.5, "same-world camera must hear source");
    // rust: let end = m.world_id("end");
    // rust: m.worlds.insert(1, end);
    // rust: data.fill(0.0);
    // rust: mix(&mut m, &mut data, 2, 48_000);
    // rust: assert_eq!(data, [0.0; 2], "no listener remains in source's world");
}

pub fn sounds_in_a_world_without_listeners_finish_while_inaudible() void {
}
    // rust: let mut mixer = Mixer::default();
    // rust: let mut source = channel(vec![1.0; 4], None, [0.0; 3], false);
    // rust: let nether = mixer.world_id("nether");
    // rust: source.world = nether;
    // rust: mixer.channels.insert(1, source);
    // rust: let mut data = [0.0; 4];
    // rust: mix(&mut mixer, &mut data, 2, 48_000);
    // rust: assert_eq!(data, [0.0; 4]);
    // rust: assert!(mixer.channels[&1].position > 0.0);
    // rust: mix(&mut mixer, &mut data, 2, 48_000);
    // rust: assert_eq!(mixer.channels[&1].state, State::Stopped);
    // rust: mixer.worlds.insert(0, nether);
    // rust: mix(&mut mixer, &mut data, 2, 48_000);
    // rust: assert_eq!(data, [0.0; 4], "returning must not resume the old one-shot");
}

pub fn variants_of_one_sound_are_the_same_sound() void {
}
    // rust: assert_eq!(
    // rust: variantless("minecraft:mob/creeper/say1.ogg"),
    // rust: "minecraft:mob/creeper/say"
    // rust: );
    // rust: assert_eq!(
    // rust: variantless("minecraft:step/grass6.ogg"),
    // rust: "minecraft:step/grass"
    // rust: );
    // rust: assert_eq!(
    // rust: variantless("minecraft:random/click.ogg"),
    // rust: "minecraft:random/click"
    // rust: );
}

pub fn another_players_copy_of_a_sound_is_dropped() void {
}
    // rust: let mixer = Arc::new(Mutex::new(Mixer::default()));
        // One other player shares the output.
    // rust: let shares = Arc::new(std::sync::atomic::AtomicUsize::new(1));
    // rust: let backend = |owner| MixerBackend {
    // rust: mixer: mixer.clone(),
    // rust: root: PathBuf::new(),
    // rust: cache: Arc::default(),
    // rust: decoder: None,
    // rust: next: (u64::from(owner)) << 40,
    // rust: live: true,
    // rust: owner,
    // rust: world: 0,
    // rust: shares: shares.clone(),
}
    // rust: let (mut p1, mut p2) = (backend(0), backend(1));
        // P2 is listening (its camera is in the mixer), so two players share the speakers.
    // rust: mixer
    // rust: .lock()
    // rust: .unwrap()
    // rust: .listeners
    // rust: .insert(1, ([0.0; 3], 0.0, 0.0));
    // rust: let started = |b: &mut MixerBackend, at: [f64; 3]| {
    // rust: let id = b.create(false).unwrap();
    // rust: b.set_position(id, at);
    // rust: !b.duplicate(id, ("minecraft", "mob/creeper/say1.ogg"))
}
    // rust: assert!(started(&mut p1, [5.0, 64.0, 5.0]));
        // P2's client got the same sound at the same place: one copy plays.
    // rust: assert!(!started(&mut p2, [5.2, 64.0, 5.0]));
        // Elsewhere, or P1's own second one, it is a sound of its own.
    // rust: assert!(started(&mut p2, [40.0, 64.0, 5.0]));
    // rust: assert!(started(&mut p1, [5.0, 64.0, 5.0]));
        // Equal coordinates in another dimension describe a different sound.
    // rust: p2.world = mixer.lock().unwrap().world_id("nether");
    // rust: assert!(started(&mut p2, [5.0, 64.0, 5.0]));
        // P2 leaving takes its sounds.
    // rust: drop(p2);
    // rust: assert!(
    // rust: mixer
    // rust: .lock()
    // rust: .unwrap()
    // rust: .channels
    // rust: .values()
    // rust: .all(|c| c.owner == 0)
    // rust: );
}

pub fn reusing_a_seat_does_not_reuse_its_channels_or_leave_its_camera() void {
}
    // rust: let host = Audio::silent(Path::new("/nonexistent/horizon-test-audio"));
    // rust: let mut guest = host.share(1);
    // rust: guest.set_world("overworld");
    // rust: guest.set_listener([1.0, 0.0, 0.0], 0.0, 0.0);
    // rust: let old = guest.backend.create(false).unwrap();
    // rust: drop(guest);
    // rust: {
    // rust: let mixer = host.backend.mixer.lock().unwrap();
    // rust: assert!(!mixer.channels.contains_key(&old));
    // rust: assert!(!mixer.listeners.contains_key(&1));
    // rust: assert!(!mixer.worlds.contains_key(&1));
}
    // rust: let mut replacement = host.share(1);
    // rust: let new = replacement.backend.create(false).unwrap();
    // rust: assert_ne!(old, new);
    // rust: assert!(
    // rust: replacement
    // rust: .backend
    // rust: .mixer
    // rust: .lock()
    // rust: .unwrap()
    // rust: .channels
    // rust: .contains_key(&new)
    // rust: );
}

pub fn a_mono_output_plays_sources_unpanned() void {
}
    // rust: let mut m = Mixer::default();
    // rust: m.channels
    // rust: .insert(1, channel(vec![0.5; 4], None, [0.0, 0.0, -3.0], true));
    // rust: let mut data = [0.0; 2];
    // rust: mix(&mut m, &mut data, 1, 48_000);
    // rust: assert_eq!(data, [0.5; 2]);
}

pub fn output_devices_are_looked_at_again_only_when_the_cards_change() void {
}
        // No fingerprint (not Linux, or the cards could not be read): the list
        // has to be looked at as before.
    // rust: assert!(cards_changed(None, None));
    // rust: assert!(cards_changed(Some("0 [PCH ]"), None));
        // The same cards list the same devices; a card added or removed does not.
    // rust: assert!(!cards_changed(Some("0 [PCH ]"), Some("0 [PCH ]")));
    // rust: assert!(cards_changed(Some("0 [PCH ]"), Some("0 [PCH ]\n 1 [USB ]")));
}
}
