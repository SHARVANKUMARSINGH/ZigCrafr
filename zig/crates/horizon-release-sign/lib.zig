//! Transpiled from Horizon Rust crate
//! Module: horizon-release-sign_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Signed release checksums (docs/security.md, "Signed updates").
//!
//! Every release carries `SHA256SUMS` (`sha256sum`'s format, `<hex>  <file>` per line) and
//! `SHA256SUMS.sig`: one base64 Ed25519 signature per line, each over `horizon release <tag>\n`
//! followed by SHA256SUMS's bytes, so a signed list can't be passed off under another tag.
//! release.yml and launcher.yml sign with the key(s) in the `release` environment's secrets
//! (tools/ci/sign_release.sh, OpenSSL only); the launcher and `horizon-server update` check a
//! download against the public keys built in from `release-keys.txt` before installing it, and
//! refuse it otherwise.
//!
//! Releases published before signing began carry no SHA256SUMS. Their archives' SHA-256s are
//! pinned in `legacy-releases.txt` (taken from GitHub when signing began, by
//! tools/ci/legacy_releases.py), so they stay installable for a rollback without trusting
//! whatever GitHub serves for them later.

// use base64::{Engine, engine::general_purpose::STANDARD};
// use ring::signature::{ED25519, Ed25519KeyPair, KeyPair, UnparsedPublicKey};

/// The checksum list's asset name.
pub const SUMS: []const u8 = "SHA256SUMS";
/// Its signatures' asset name.
pub const SIGNATURE: []const u8 = "SHA256SUMS.sig";
/// A Nightly's second signature file: the same checksum list signed for the Nightly's own version
/// (`horizon release nightly-<date>-<commit>`) rather than for the channel, so an older Nightly can't
/// be served as a newer one. Nightlies carry both while launchers that only read [`SIGNATURE`] are
/// in use (docs/security.md, "Nightly signatures"); current launchers and servers require this one.
pub const SIGNATURE_V2: []const u8 = "SHA256SUMS.v2.sig";

pub const KEYS: []const u8 = include_str!("../release-keys.txt");
pub const LEGACY: []const u8 = include_str!("../legacy-releases.txt");

/// An Ed25519 public key.
    // rust: pub type PublicKey = [u8; 32];

/// The public keys built in: those in `release-keys.txt`. A file that doesn't parse gives none,
/// so every download is refused rather than trusted (a test keeps the file valid).
pub fn trusted_keys() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_keys(KEYS).unwrap_or_default()
}

/// The keys in a keys file: one base64 key per line; blank lines and `#` comments are skipped.
pub fn parse_keys(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines()
    // rust: .map(str::trim)
    // rust: .filter(|line| !line.is_empty() && !line.starts_with('#'))
    // rust: .map(|line| {
    // rust: let bytes = STANDARD
    // rust: .decode(line)
    // rust: .map_err(|e| format!("{line}: not base64 ({e})"))?;
    // rust: PublicKey::try_from(bytes.as_slice())
    // rust: .map_err(|_| format!("{line}: not a 32-byte Ed25519 public key"))
    // rust: })
    // rust: .collect()
}

/// What a signature covers: the tag, then the checksum list.
pub fn message(tag: []const u8, sums: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut message = format!("horizon release {tag}\n").into_bytes();
    // rust: message.extend_from_slice(sums);
    // rust: message
}

/// A checksum list for `(file name, SHA-256 hex)` pairs, as `sha256sum` writes it.
pub fn sums_file(files: *[([]const u8) void {
}
    // rust: files
    // rust: .iter()
    // rust: .map(|(name, hex)| format!("{hex}  {name}\n"))
    // rust: .collect()
}

/// The `(file name, SHA-256 hex)` pairs of a checksum list (`<hex>  <name>` or `<hex> *<name>`).
pub fn parse_sums(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines()
    // rust: .filter(|line| !line.trim().is_empty())
    // rust: .map(|line| {
    // rust: let (hex, name) = line
    // rust: .split_once(' ')
    // rust: .ok_or_else(|| format!("{SUMS}: {line:?} is not `<sha256>  <file>`"))?;
    // rust: let name = name.strip_prefix([' ', '*']).unwrap_or(name);
    // rust: if hex.len() != 64 || !hex.bytes().all(|b| b.is_ascii_hexdigit()) || name.is_empty() {
    // rust: return Err(format!("{SUMS}: {line:?} is not `<sha256>  <file>`"));
}
    // rust: Ok((name.to_string(), hex.to_ascii_lowercase()))
    // rust: })
    // rust: .collect()
}

/// Checks that one of `keys` signed `sums` for `tag`, and returns the list.
    // rust: pub fn verify(
    // rust: tag: &str,
    // rust: sums: &[u8],
    // rust: signature: &str,
    // rust: keys: &[PublicKey],
    // rust: ) -> Result<Vec<(String, String)>, String> {
    // rust: if keys.is_empty() {
    // rust: return Err(
    // rust: "This build has no release key built in, so it can't check downloads: none are installed."
    // rust: .into(),
    // rust: );
}
    // rust: let message = message(tag, sums);
    // rust: let signed = signature
    // rust: .lines()
    // rust: .filter_map(|line| STANDARD.decode(line.trim()).ok())
    // rust: .any(|signature| {
    // rust: keys.iter().any(|key| {
    // rust: UnparsedPublicKey::new(&ED25519, key)
    // rust: .verify(&message, &signature)
    // rust: .is_ok()
    // rust: })
    // rust: });
    // rust: if !signed {
    // rust: return Err(format!(
    // rust: "{tag}'s signature doesn't match Horizon's release key, so it was not installed. \
    // rust: The download may have been tampered with: please report it on Discord or GitHub."
    // rust: ));
}
    // rust: let text = std::str::from_utf8(sums).map_err(|_| format!("{SUMS} is not text"))?;
    // rust: parse_sums(text)
}

/// The channel nightly builds are signed for (nightly-build.yml): their message is
/// `horizon release nightly`, which no release's tag is, so a nightly's signature never passes for a
/// release's, nor a release's for a nightly's.
pub const NIGHTLY: []const u8 = "nightly";

/// Whether `tag` is a nightly's: `nightly`, or a past one kept as `nightly-<date>`.
pub fn is_nightly(tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag == NIGHTLY || tag.starts_with("nightly-")
}

/// The version a nightly is listed as, from its release title ("Nightly 2026-10-28 · 0c02067"):
/// `nightly-2026-10-28-0c02067`. `published` (GitHub's `published_at`) dates a title without one.
/// For listing only: what installs is checked against [`nightly_title_version`], which has no
/// fallback, since nothing signs `published`.
pub fn nightly_version(title: []const u8, published: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut words = title
    // rust: .strip_prefix("Nightly ")
    // rust: .unwrap_or_default()
    // rust: .split(" · ");
    // rust: let date = words
    // rust: .next()
    // rust: .filter(|d| is_date(d))
    // rust: .unwrap_or_else(|| published.get(..10).unwrap_or(published));
    // rust: let commit = words
    // rust: .next()
    // rust: .filter(|c| !c.is_empty() && c.chars().all(|c| c.is_ascii_hexdigit()));
    // rust: match commit {
    // rust: Some(commit) => format!("{NIGHTLY}-{date}-{commit}"),
    // rust: None => format!("{NIGHTLY}-{date}"),
}
}

/// The date of a nightly's version or tag (`nightly-2026-10-28-0c02067`, `nightly-2026-10-28`):
/// nightlies follow every release and each other by it.
pub fn nightly_date(version: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let date = version.strip_prefix("nightly-")?.get(..10)?;
    // rust: is_date(date).then_some(date)
}

pub fn is_date(text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.len() == 10
    // rust: && text.chars().enumerate().all(|(i, c)| {
    // rust: if i == 4 || i == 7 {
    // rust: c == '-'
    // rust: } else {
    // rust: c.is_ascii_digit()
}
    // rust: })
}

/// The signed SHA-256 of `asset` in release `tag`, or why the download must be refused.
/// `sums` and `signature` are the release's SHA256SUMS and SHA256SUMS.sig, None when it has none.
/// A nightly is never a release: its tags are refused here, whatever their signature
/// ([`nightly_digest`] checks those).
    // rust: pub fn signed_digest(
    // rust: tag: &str,
    // rust: asset: &str,
    // rust: sums: Option<&[u8]>,
    // rust: signature: Option<&str>,
    // rust: keys: &[PublicKey],
    // rust: ) -> Result<String, String> {
    // rust: if is_nightly(tag) {
    // rust: return Err(format!(
    // rust: "{tag} is a Nightly build: only a launcher with Nightly turned on installs it."
    // rust: ));
}
    // rust: digest_in(tag, tag, asset, sums, signature, keys)
}

/// The version a Nightly's GitHub title names, strictly: `Nightly 2026-10-28 · 0c02067` (as
/// nightly-build.yml writes it) gives `nightly-2026-10-28-0c02067`. Anything else is None: a
/// Nightly is verified against the version it installs as, so a title that doesn't name its date
/// and commit is refused rather than dated by when GitHub says it was published.
pub fn nightly_title_version(title: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (date, commit) = title.strip_prefix("Nightly ")?.split_once(" · ")?;
    // rust: let commit_ok = (7..=40).contains(&commit.len())
    // rust: && commit
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b));
    // rust: (is_date(date) && commit_ok).then(|| format!("{NIGHTLY}-{date}-{commit}"))
}

/// Whether `version` is a Nightly build's full version, `nightly-<date>-<commit>`, the form its
/// [`SIGNATURE_V2`] is signed for.
pub fn is_nightly_build(version: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: version
    // rust: .strip_prefix("nightly-")
    // rust: .and_then(|rest| rest.split_at_checked(10))
    // rust: .is_some_and(|(date, commit)| {
    // rust: is_date(date)
    // rust: && commit.strip_prefix('-').is_some_and(|c| {
    // rust: (7..=40).contains(&c.len())
    // rust: && c.bytes()
    // rust: .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))
    // rust: })
    // rust: })
}

/// The signed SHA-256 of `asset` in the Nightly that installs as `version`
/// (`nightly-<date>-<commit>`, from [`nightly_title_version`]): `signature` is its
/// [`SIGNATURE_V2`], which must sign `sums` for exactly that version. A release's list, the channel
/// signature (`nightly`) and another Nightly's are all refused, so an older Nightly can't be passed off
/// as tonight's.
    // rust: pub fn nightly_digest(
    // rust: version: &str,
    // rust: asset: &str,
    // rust: sums: Option<&[u8]>,
    // rust: signature: Option<&str>,
    // rust: keys: &[PublicKey],
    // rust: ) -> Result<String, String> {
    // rust: if !is_nightly_build(version) {
    // rust: return Err(format!(
    // rust: "{version:?} doesn't name a Nightly's date and commit, so it can't be checked: not installed."
    // rust: ));
}
    // rust: let Some(signature) = signature else {
    // rust: return Err(format!(
    // rust: "{version} has no {SIGNATURE_V2} (its signature for this exact build): it was published \
    // rust: before Nightlies were signed for their own version, so it can't be checked and was not \
    // rust: installed. Pick a Nightly published since then; `horizon-server rollback` still goes back \
    // rust: to a build a server already has."
    // rust: ));
}
    // rust: digest_in(version, version, asset, sums, Some(signature), keys)
}

/// `asset`'s SHA-256 in `sums`, once one of `keys` is found to have signed them for `signed_for`;
/// `name` says which build in messages.
    // rust: fn digest_in(
    // rust: signed_for: &str,
    // rust: name: &str,
    // rust: asset: &str,
    // rust: sums: Option<&[u8]>,
    // rust: signature: Option<&str>,
    // rust: keys: &[PublicKey],
    // rust: ) -> Result<String, String> {
    // rust: let (Some(sums), Some(signature)) = (sums, signature) else {
    // rust: return Err(format!(
    // rust: "{name} is not signed, and Horizon installs only signed releases: pick a newer version."
    // rust: ));
}
    // rust: verify(signed_for, sums, signature, keys)?
    // rust: .into_iter()
    // rust: .find(|(n, _)| n == asset)
    // rust: .map(|(_, hex)| hex)
    // rust: .ok_or_else(|| {
    // rust: format!("{asset} is not in {name}'s signed checksums, so it was not installed.")
    // rust: })
}

/// The pinned SHA-256 of `asset` in a release from before signing (legacy-releases.txt). Callers
/// use it instead of the release's files when there is one: [`signed_digest`] otherwise.
pub fn legacy_digest(tag: []const u8, asset: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: legacy_entries(LEGACY).find_map(|(t, a, hex)| (t == tag && a == asset).then_some(hex))
}

/// The `<tag> <asset> <sha256>` lines of a legacy releases file; blank lines and `#` comments skipped.
pub fn legacy_entries(text: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines()
    // rust: .map(str::trim)
    // rust: .filter(|line| !line.is_empty() && !line.starts_with('#'))
    // rust: .filter_map(|line| {
    // rust: let mut parts = line.split_whitespace();
    // rust: Some((parts.next()?, parts.next()?, parts.next()?))
    // rust: })
}

/// Whether a downloaded file's SHA-256 (`got`) is the signed one.
pub fn check(asset: []const u8, expected: []const u8, got: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if expected.eq_ignore_ascii_case(got) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "{asset} doesn't match its signed checksum (corrupted or tampered with), so it was \
    // rust: not installed. Try again."
    // rust: ))
}
}

/// SHA-256 over data that arrives in pieces (a download).
pub const Sha256 = struct {};

    // rust: impl Default for Sha256 {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(ring::digest::Context::new(&ring::digest::SHA256))
}
}

    // rust: impl Sha256 {
pub fn update(self: *Self, bytes: []const u8) void {
}
    // rust: self.0.update(bytes);
}

pub fn hex(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
    // rust: .finish()
    // rust: .as_ref()
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect()
}
}

/// The SHA-256 of `bytes`, in hex.
pub fn sha256_hex(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut hash = Sha256::default();
    // rust: hash.update(bytes);
    // rust: hash.hex()
}

/// A private signing key: `keygen` makes them, and tests sign with them (releases are signed by
/// OpenSSL in tools/ci/sign_release.sh, from the same PKCS#8 document).
pub const SigningKey = struct {};

    // rust: impl SigningKey {
    /// A new key, and its PKCS#8 document in base64 (what the secret holds).
    ///
    /// The document is PKCS#8 v1 (RFC 8410: the 32-byte seed alone), which every OpenSSL 3 reads;
    /// ring makes v2 (with the public key too), which OpenSSL 3.0, Ubuntu's, refuses.
pub fn generate() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const V2_PREFIX: [u8; 16] = [
    // rust: 0x30, 0x51, 0x02, 0x01, 0x01, 0x30, 0x05, 0x06, 0x03, 0x2b, 0x65, 0x70, 0x04, 0x22,
    // rust: 0x04, 0x20,
    // rust: ];
    // rust: const V1_PREFIX: [u8; 16] = [
    // rust: 0x30, 0x2e, 0x02, 0x01, 0x00, 0x30, 0x05, 0x06, 0x03, 0x2b, 0x65, 0x70, 0x04, 0x22,
    // rust: 0x04, 0x20,
    // rust: ];
    // rust: let v2 = Ed25519KeyPair::generate_pkcs8(&ring::rand::SystemRandom::new())
    // rust: .map_err(|_| "no randomness to make a key with".to_string())?;
    // rust: let seed = v2
    // rust: .as_ref()
    // rust: .strip_prefix(&V2_PREFIX)
    // rust: .and_then(|rest| rest.get(..32))
    // rust: .ok_or("ring's key document has an unexpected layout")?;
    // rust: let v1 = [&V1_PREFIX[..], seed].concat();
    // rust: let key = Ed25519KeyPair::from_pkcs8_maybe_unchecked(&v1)
    // rust: .map_err(|_| "the new key doesn't parse".to_string())?;
    // rust: let same = Ed25519KeyPair::from_pkcs8(v2.as_ref())
    // rust: .is_ok_and(|k| k.public_key().as_ref() == key.public_key().as_ref());
    // rust: if !same {
    // rust: return Err("the new key's two forms disagree".into());
}
    // rust: Ok((Self(key), STANDARD.encode(&v1)))
}

    /// The key a secret holds (base64 PKCS#8). The error never quotes the secret.
pub fn from_base64(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let document = STANDARD
    // rust: .decode(text.trim())
    // rust: .map_err(|_| "the signing key is not base64".to_string())?;
    // rust: Ed25519KeyPair::from_pkcs8_maybe_unchecked(&document)
    // rust: .map(Self)
    // rust: .map_err(|_| "the signing key is not an Ed25519 PKCS#8 key".to_string())
}

pub fn public(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PublicKey::try_from(self.0.public_key().as_ref()).expect("Ed25519 public keys are 32 bytes")
}

    /// The public key in base64, as release-keys.txt lists it.
pub fn public_base64(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: STANDARD.encode(self.public())
}

    /// A signature line for SHA256SUMS.sig.
pub fn sign(self: *Self, tag: []const u8, sums: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: STANDARD.encode(self.0.sign(&message(tag, sums)).as_ref())
}
}

    // rust: mod tests {
//     use super::*;

pub fn signed(tag: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (key, _) = SigningKey::generate().unwrap();
    // rust: let sums = sums_file(&[
    // rust: ("horizon-linux-x86_64.tar.gz".into(), sha256_hex(b"linux")),
    // rust: ("horizon-windows-x64.zip".into(), sha256_hex(b"windows")),
    // rust: ]);
    // rust: let signature = key.sign(tag, sums.as_bytes()) + "\n";
    // rust: (key, sums, signature)
}

pub fn the_built_in_keys_file_parses() void {
}
    // rust: assert!(parse_keys(KEYS).is_ok());
}

pub fn releases_from_before_signing_keep_their_pinned_digests() void {
}
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for line in LEGACY.lines().map(str::trim) {
    // rust: if line.is_empty() || line.starts_with('#') {
    // rust: continue;
}
    // rust: let parts: Vec<&str> = line.split_whitespace().collect();
    // rust: assert_eq!(parts.len(), 3, "{line}");
    // rust: assert_eq!(parts[2].len(), 64, "{line}");
    // rust: assert!(
    // rust: parts[2]
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_hexdigit() && !b.is_ascii_uppercase()),
    // rust: "{line}"
    // rust: );
    // rust: assert!(seen.insert((parts[0], parts[1])), "listed twice: {line}");
}
    // rust: if let Some((tag, asset, hex)) = legacy_entries(LEGACY).next() {
    // rust: assert_eq!(legacy_digest(tag, asset), Some(hex));
    // rust: assert_eq!(legacy_digest(tag, "not-an-asset.zip"), None);
}
    // rust: assert_eq!(
    // rust: legacy_digest("v2099.01.01", "horizon-windows-x64.zip"),
    // rust: None
    // rust: );
}

pub fn a_signed_release_gives_its_digests() void {
}
    // rust: let (key, sums, signature) = signed("v2026.10.19");
    // rust: let digest = signed_digest(
    // rust: "v2026.10.19",
    // rust: "horizon-windows-x64.zip",
    // rust: Some(sums.as_bytes()),
    // rust: Some(&signature),
    // rust: &[key.public()],
    // rust: );
    // rust: assert_eq!(digest, Ok(sha256_hex(b"windows")));
    // rust: assert!(check("x", &sha256_hex(b"windows"), &sha256_hex(b"windows")).is_ok());
    // rust: assert!(check("x", &sha256_hex(b"windows"), &sha256_hex(b"linux")).is_err());
}

    /// The release channel refuses everything signed for the nightly channel, and the other way
    /// round: one key signs both, and only the message's channel keeps them apart.
pub fn nightly_and_release_signatures_never_pass_for_each_other() void {
}
pub const TONIGHT: []const u8 = "nightly-2026-10-28-0c02067";
    // rust: let (nightly, sums, signature) = signed(TONIGHT);
    // rust: let keys = [nightly.public()];
    // rust: let asset = "horizon-windows-x64.zip";
    // rust: let digest = nightly_digest(
    // rust: TONIGHT,
    // rust: asset,
    // rust: Some(sums.as_bytes()),
    // rust: Some(&signature),
    // rust: &keys,
    // rust: );
    // rust: assert_eq!(digest, Ok(sha256_hex(b"windows")));
        // Served under a release's tag: the message names the Nightly, not v0.2.81.
    // rust: for tag in ["v0.2.81", "v2026.10.28", "0.2.81"] {
    // rust: let as_release =
    // rust: signed_digest(tag, asset, Some(sums.as_bytes()), Some(&signature), &keys);
    // rust: assert!(as_release.is_err(), "{tag} took a nightly's signature");
}
        // Asked for by a nightly tag on the release channel: refused before any signature is read.
    // rust: for tag in [NIGHTLY, "nightly-2026-10-27", TONIGHT] {
    // rust: let err = signed_digest(tag, asset, Some(sums.as_bytes()), Some(&signature), &keys);
    // rust: assert!(err.unwrap_err().contains("Nightly build"), "{tag}");
}
        // A release's signed list replayed as tonight's nightly.
    // rust: let (release, sums, signature) = signed("v0.2.81");
    // rust: let keys = [release.public()];
    // rust: assert!(
    // rust: nightly_digest(
    // rust: TONIGHT,
    // rust: asset,
    // rust: Some(sums.as_bytes()),
    // rust: Some(&signature),
    // rust: &keys
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(nightly_digest(TONIGHT, asset, Some(sums.as_bytes()), None, &keys).is_err());
    // rust: assert!(is_nightly("nightly-2026-10-27") && !is_nightly("v0.2.81"));
}

pub fn an_older_nightly_is_not_tonights() void {
}
    // rust: let asset = "horizon-windows-x64.zip";
        // Last week's build, re-served under tonight's title: its v2 signature names last week.
    // rust: let (key, sums, old) = signed("nightly-2026-10-21-aaaaaaa");
    // rust: let keys = [key.public()];
    // rust: let tonight = nightly_title_version("Nightly 2026-10-28 · 0c02067").unwrap();
    // rust: let err = nightly_digest(&tonight, asset, Some(sums.as_bytes()), Some(&old), &keys);
    // rust: assert!(err.is_err(), "an older Nightly passed as {tonight}");
        // The channel signature (SHA256SUMS.sig, for launchers from before v2) is no v2 signature.
    // rust: let (key, sums, channel) = signed(NIGHTLY);
    // rust: let keys = [key.public()];
    // rust: assert!(
    // rust: nightly_digest(
    // rust: &tonight,
    // rust: asset,
    // rust: Some(sums.as_bytes()),
    // rust: Some(&channel),
    // rust: &keys
    // rust: )
    // rust: .is_err()
    // rust: );
        // And a version that isn't a full Nightly build is refused whatever signs it.
    // rust: for version in [NIGHTLY, "nightly-2026-10-28", "v0.2.81"] {
    // rust: let (key, sums, signature) = signed(version);
    // rust: let err = nightly_digest(
    // rust: version,
    // rust: asset,
    // rust: Some(sums.as_bytes()),
    // rust: Some(&signature),
    // rust: &[key.public()],
    // rust: );
    // rust: assert!(err.unwrap_err().contains("doesn't name"), "{version}");
}
}

pub fn a_nightlys_title_is_parsed_strictly() void {
}
    // rust: assert_eq!(
    // rust: nightly_title_version("Nightly 2026-10-28 · 0c02067").as_deref(),
    // rust: Some("nightly-2026-10-28-0c02067")
    // rust: );
    // rust: assert_eq!(
    // rust: nightly_title_version(&format!("Nightly 2026-10-28 · {}", "a".repeat(40))),
    // rust: Some(format!("nightly-2026-10-28-{}", "a".repeat(40)))
    // rust: );
    // rust: for title in [
    // rust: "Something else",
    // rust: "Nightly 2026-10-28",
    // rust: "Nightly 2026-10-28 · ",
    // rust: "Nightly 2026-10-28 · 0c020",     // too short
    // rust: "Nightly 2026-10-28 · 0C02067",   // GitHub's short SHAs are lowercase
    // rust: "Nightly 2026-10-28 · 0c02067 x", // trailing words
    // rust: "Nightly 2026-1-28 · 0c02067",    // not a date
    // rust: "nightly 2026-10-28 · 0c02067",
    // rust: " Nightly 2026-10-28 · 0c02067",
    // rust: "Nightly 2026-10-28 · 0c02067/../x",
    // rust: ] {
    // rust: assert_eq!(nightly_title_version(title), None, "{title:?}");
}
    // rust: assert!(is_nightly_build("nightly-2026-10-28-0c02067"));
    // rust: assert!(!is_nightly_build("nightly-2026-10-28"));
    // rust: assert!(!is_nightly_build("nightly-2026-10-28-"));
    // rust: assert!(!is_nightly_build("nightly-2026-10-28-0c02067-x"));
}

pub fn a_nightly_is_named_by_its_date_and_commit() void {
}
    // rust: let v = nightly_version("Nightly 2026-10-28 · 0c02067", "2026-10-28T20:40:00Z");
    // rust: assert_eq!(v, "nightly-2026-10-28-0c02067");
    // rust: assert_eq!(
    // rust: nightly_version("Something else", "2026-10-29T01:00:00Z"),
    // rust: "nightly-2026-10-29"
    // rust: );
    // rust: assert_eq!(nightly_date(&v), Some("2026-10-28"));
    // rust: assert_eq!(nightly_date("nightly-2026-10-27"), Some("2026-10-27"));
    // rust: assert_eq!(nightly_date("nightly"), None);
    // rust: assert_eq!(nightly_date("v0.2.95"), None);
    // rust: assert!(is_nightly(&v));
}

pub fn tampering_is_refused() void {
}
    // rust: let (key, sums, signature) = signed("v2026.10.19");
    // rust: let keys = [key.public()];
        // Another tag: an old signed list replayed for a new release.
    // rust: assert!(verify("v2026.10.20", sums.as_bytes(), &signature, &keys).is_err());
        // A changed checksum.
    // rust: let changed = sums.replacen(&sha256_hex(b"linux"), &sha256_hex(b"evil"), 1);
    // rust: assert!(verify("v2026.10.19", changed.as_bytes(), &signature, &keys).is_err());
        // Another key.
    // rust: let (other, _) = SigningKey::generate().unwrap();
    // rust: assert!(
    // rust: verify(
    // rust: "v2026.10.19",
    // rust: sums.as_bytes(),
    // rust: &signature,
    // rust: &[other.public()]
    // rust: )
    // rust: .is_err()
    // rust: );
        // No signature, no keys, an asset that isn't listed.
    // rust: let none = signed_digest("v2026.10.19", "a", None, None, &keys).unwrap_err();
    // rust: assert!(none.contains("not signed"), "{none}");
    // rust: assert!(verify("v2026.10.19", sums.as_bytes(), &signature, &[]).is_err());
    // rust: let missing = signed_digest(
    // rust: "v2026.10.19",
    // rust: "horizon-macos-arm64.zip",
    // rust: Some(sums.as_bytes()),
    // rust: Some(&signature),
    // rust: &keys,
    // rust: );
    // rust: assert!(missing.unwrap_err().contains("not in"));
}

pub fn any_line_signed_by_any_trusted_key_passes() void {
}
        // While rotating, releases carry one signature per key and launchers trust one or both.
    // rust: let (old, sums, old_line) = signed("v1");
    // rust: let (new, _) = SigningKey::generate().unwrap();
    // rust: let both = format!("{old_line}{}\n", new.sign("v1", sums.as_bytes()));
    // rust: assert!(verify("v1", sums.as_bytes(), &both, &[old.public()]).is_ok());
    // rust: assert!(verify("v1", sums.as_bytes(), &both, &[new.public()]).is_ok());
    // rust: assert!(verify("v1", sums.as_bytes(), "garbage\n\n", &[old.public()]).is_err());
}

pub fn keys_round_trip_through_their_text_forms() void {
}
    // rust: let (key, secret) = SigningKey::generate().unwrap();
        // PKCS#8 v1 (version 0, the seed alone): what OpenSSL 3.0 reads.
    // rust: let document = STANDARD.decode(&secret).unwrap();
    // rust: assert_eq!((document.len(), document[4]), (48, 0));
    // rust: let again = SigningKey::from_base64(&format!("{secret}\n")).unwrap();
    // rust: assert_eq!(again.public(), key.public());
    // rust: assert_eq!(
    // rust: parse_keys(&format!("# comment\n\n{}\n", key.public_base64())),
    // rust: Ok(vec![key.public()])
    // rust: );
    // rust: assert!(parse_keys("AAAA\n").is_err());
    // rust: let error = SigningKey::from_base64("bm90IGEga2V5").err().unwrap();
    // rust: assert!(!error.contains("bm90"));
}

pub fn checksum_lists_read_both_sha256sum_forms() void {
}
    // rust: let hex = sha256_hex(b"x");
    // rust: let list =
    // rust: parse_sums(&format!("{hex}  a.zip\n{} *b.tar.gz\n", hex.to_uppercase())).unwrap();
    // rust: assert_eq!(
    // rust: list,
    // rust: [("a.zip".into(), hex.clone()), ("b.tar.gz".into(), hex)]
    // rust: );
    // rust: assert!(parse_sums("nothex  a.zip\n").is_err());
}
}
