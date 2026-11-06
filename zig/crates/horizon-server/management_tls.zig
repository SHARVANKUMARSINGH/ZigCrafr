//! Transpiled from Horizon Rust crate
//! Module: horizon-server_management_tls
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! TLS for vanilla's management protocol (`management-server-tls-*`), on by default as in vanilla, set up as
//! vanilla's `JsonRpcSslContextProvider` sets it up: a PKCS12 keystore holding the server's certificate and
//! key, its password from the `MINECRAFT_MANAGEMENT_TLS_KEYSTORE_PASSWORD` environment variable, else
//! `management-server-tls-keystore-password`. Vanilla won't start with TLS on and no keystore; Horizon makes
//! one instead (a self-signed certificate in `.horizon/`), so turning the protocol on is enough, and logs the
//! certificate's fingerprint for clients to pin.

// use horizon_server_files::properties::{SystemEntropy, generate_secret_key};
// use p12_keystore::{Certificate, KeyStore, KeyStoreEntry, PrivateKeyChain};
// use rustls::pki_types::{CertificateDer, PrivateKeyDer, PrivatePkcs8KeyDer};
// use sha2::{Digest, Sha256};
// use std::{path::Path, sync::Arc};

pub const PASSWORD_VARIABLE: []const u8 = "MINECRAFT_MANAGEMENT_TLS_KEYSTORE_PASSWORD";

/// Where the generated keystore goes, relative to the server's folder.
pub const GENERATED: []const u8 = ".horizon/management-keystore.p12";

/// `JsonRpcSslContextProvider.printInstructions`, with the Horizon way: server.toml's `[properties]`.
    // rust: pub const INSTRUCTIONS: [&str; 5] = [
    // rust: "To use TLS for the management server, please follow these steps:",
    // rust: "1. Set the server property 'management-server-tls-enabled' to 'true' to enable TLS",
    // rust: "2. Create a keystore file of type PKCS12 containing your server certificate and private key",
    // rust: "3. Set the server property 'management-server-tls-keystore' to the path of your keystore file",
    // rust: "4. Set the keystore password via the environment variable 'MINECRAFT_MANAGEMENT_TLS_KEYSTORE_PASSWORD', or \
    // rust: server property 'management-server-tls-keystore-password'",
    // rust: ];

/// The server's TLS session settings, and its certificate's SHA-256 fingerprint.
pub const Tls = struct {
    config: *rustls::ServerConfig,
    fingerprint: []const u8,
};

/// `getKeystorePassword`: the environment's, else server.properties'.
pub fn password(from_properties: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var(PASSWORD_VARIABLE).unwrap_or_else(|_| from_properties.to_owned())
}

/// `createFrom`: the keystore at `path` (relative to the server's folder, vanilla's working directory).
pub fn load(dir: *Path, path: []const u8, password: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if path.is_empty() {
    // rust: return Err("TLS is enabled but keystore is not configured".into());
}
    // rust: let file = dir.join(path);
    // rust: if !file.is_file() {
    // rust: return Err(format!(
    // rust: "Supplied keystore is not a file or does not exist: '{path}'"
    // rust: ));
}
    // rust: let data = std::fs::read(&file).map_err(|e| format!("'{path}': {e}"))?;
    // rust: let store = KeyStore::from_pkcs12(&data, password)
    // rust: .map_err(|e| format!("Couldn't open the keystore '{path}' (wrong password?): {e}"))?;
    // rust: let Some((_, chain)) = store.private_key_chain() else {
    // rust: return Err(format!(
    // rust: "The keystore '{path}' holds no private key with its certificate"
    // rust: ));
}
    // rust: let certificates: Vec<CertificateDer<'static>> = chain
    // rust: .chain()
    // rust: .iter()
    // rust: .map(|c| CertificateDer::from(c.as_der().to_vec()))
    // rust: .collect();
    // rust: let Some(leaf) = certificates.first() else {
    // rust: return Err(format!(
    // rust: "The keystore '{path}' has no certificate for its key"
    // rust: ));
}
    // rust: let fingerprint = fingerprint(leaf);
    // rust: let key = PrivateKeyDer::Pkcs8(PrivatePkcs8KeyDer::from(chain.key().to_vec()));
    // rust: let config = rustls::ServerConfig::builder_with_provider(Arc::new(
    // rust: rustls::crypto::ring::default_provider(),
    // rust: ))
    // rust: .with_safe_default_protocol_versions()
    // rust: .map_err(|e| e.to_string())?
    // rust: .with_no_client_auth()
    // rust: .with_single_cert(certificates, key)
    // rust: .map_err(|e| format!("The keystore '{path}': {e}"))?;
    // rust: Ok(Tls {
    // rust: config: Arc::new(config),
    // rust: fingerprint,
    // rust: })
}

/// A keystore with a new self-signed certificate for localhost and `host`, written to [`GENERATED`] for its
/// owner only; its password.
pub fn generate(dir: *Path, host: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut names: Vec<String> = ["localhost", "127.0.0.1", "::1"].map(String::from).into();
    // rust: if !host.is_empty() && !matches!(host, "0.0.0.0" | "::") && !names.iter().any(|n| n == host) {
    // rust: names.push(host.to_owned());
}
    // rust: let rcgen::CertifiedKey { cert, signing_key } =
    // rust: rcgen::generate_simple_self_signed(names).map_err(|e| e.to_string())?;
    // rust: let certificate = Certificate::from_der(cert.der()).map_err(|e| e.to_string())?;
    // rust: let id = Sha256::digest(cert.der());
    // rust: let mut store = KeyStore::new();
    // rust: store.add_entry(
    // rust: "horizon",
    // rust: KeyStoreEntry::PrivateKeyChain(PrivateKeyChain::new(
    // rust: signing_key.serialize_der(),
    // rust: &id[..20],
    // rust: [certificate],
    // rust: )),
    // rust: );
    // rust: let password = generate_secret_key(&mut SystemEntropy::default());
    // rust: let data = store.writer(&password).write().map_err(|e| e.to_string())?;
    // rust: let file = dir.join(GENERATED);
    // rust: if let Some(parent) = file.parent() {
    // rust: std::fs::create_dir_all(parent).map_err(|e| e.to_string())?;
}
    // rust: crate::api::write_private(&file, &data).map_err(|e| format!("{GENERATED}: {e}"))?;
    // rust: Ok(password)
}

/// SHA-256 of a certificate, as `keytool -list` prints it.
pub fn fingerprint(certificate: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Sha256::digest(certificate)
    // rust: .iter()
    // rust: .map(|b| format!("{b:02X}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(":")
}

    // rust: mod tests {
//     use super::*;

pub fn a_generated_keystore_opens_as_vanillas_would() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-management-tls-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let password = generate(&dir, "example.org").unwrap();
    // rust: assert_eq!(password.len(), 40);
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: let mode = std::fs::metadata(dir.join(GENERATED))
    // rust: .unwrap()
    // rust: .permissions()
    // rust: .mode();
    // rust: assert_eq!(mode & 0o777, 0o600);
}
    // rust: let tls = load(&dir, GENERATED, &password).unwrap();
    // rust: assert_eq!(tls.fingerprint.len(), 32 * 3 - 1);
    // rust: assert!(load(&dir, GENERATED, "wrong").is_err());
    // rust: assert_eq!(
    // rust: load(&dir, "", &password).err().unwrap(),
    // rust: "TLS is enabled but keystore is not configured"
    // rust: );
    // rust: assert_eq!(
    // rust: load(&dir, "nope.p12", &password).err().unwrap(),
    // rust: "Supplied keystore is not a file or does not exist: 'nope.p12'"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
