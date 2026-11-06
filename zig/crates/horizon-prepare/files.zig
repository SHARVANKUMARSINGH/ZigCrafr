//! Transpiled from Horizon Rust crate
//! Module: horizon-prepare_files
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Independent copies, using filesystem cloning when available. Never hard links: exporters
//! rewrite prepared resources in place. Checked imports publish only after verifying the copy.

// use crate::{digest, hex};
// use sha2::Digest;
// use std::fs;
// use std::io::{self, Read, Write};
// use std::path::{Path, PathBuf};
// use std::sync::atomic::{AtomicUsize, Ordering};

pub fn clone_file(from: *Path, to: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
//         use std::os::fd::AsRawFd;
    // rust: let source = fs::File::open(from)?;
    // rust: let target = fs::File::create(to)?;
        // SAFETY: FICLONE takes a source fd, both descriptors stay open for the call.
    // rust: if unsafe { libc::ioctl(target.as_raw_fd(), libc::FICLONE, source.as_raw_fd()) } == 0 {
    // rust: return Ok(());
}
    // rust: Err(io::Error::last_os_error())
}
    // rust: {
//         use std::ffi::CString;
//         use std::os::unix::ffi::OsStrExt;
    // rust: let path = |p: &Path| {
    // rust: CString::new(p.as_os_str().as_bytes())
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidInput, e))
}
    // rust: let (source, target) = (path(from)?, path(to)?);
        // SAFETY: both paths are valid NUL-terminated strings for the duration of the call.
    // rust: if unsafe { libc::clonefile(source.as_ptr(), target.as_ptr(), 0) } == 0 {
    // rust: return Ok(());
}
    // rust: Err(io::Error::last_os_error())
}
    // rust: {
    // rust: let _ = (from, to);
    // rust: Err(io::ErrorKind::Unsupported.into())
}
}

/// Copies an independent file, attempting a reflink first. The destination may be replaced.
pub fn clone_or_copy(from: *Path, to: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: clone_file(from, to).or_else(|_| fs::copy(from, to).map(|_| ()))
}

    // rust: fn copy_hash<D: Digest>(from: &Path, to: &Path) -> io::Result<String> {
    // rust: let mut source = fs::File::open(from)?;
    // rust: let mut target = fs::File::create(to)?;
    // rust: let mut hash = D::new();
    // rust: let mut buffer = vec![0; 64 * 1024];
    // rust: loop {
    // rust: let n = source.read(&mut buffer)?;
    // rust: if n == 0 {
    // rust: return Ok(hex(&hash.finalize()));
}
    // rust: target.write_all(&buffer[..n])?;
    // rust: hash.update(&buffer[..n]);
}
}

/// A verified replacement staged beside its destination. Dropping an unfinished set cleans
/// every temporary file, so a corrupt late panorama face cannot replace earlier placeholders.
    // rust: pub(crate) struct Import {
    // rust: temporary: Option<PathBuf>,
    // rust: destination: PathBuf,
}

    // rust: impl Import {
    // rust: pub(crate) fn stage(
    // rust: source: &Path,
    // rust: destination: &Path,
    // rust: checksum: &str,
    // rust: algorithm: &str,
    // rust: verified: bool,
    // rust: ) -> Result<Self, String> {
    // rust: let mut import = Self {
    // rust: temporary: None,
    // rust: destination: destination.into(),
}
    // rust: if verified || (destination.is_file() && digest(destination, algorithm)? == checksum) {
    // rust: return Ok(import);
}
    // rust: fs::create_dir_all(destination.parent().unwrap()).map_err(|e| e.to_string())?;
pub const COPIES: AtomicUsize = AtomicUsize::new(0);
    // rust: let temporary = destination.with_file_name(format!(
    // rust: ".{}.partial-{}-{}",
    // rust: destination.file_name().unwrap().to_string_lossy(),
    // rust: std::process::id(),
    // rust: COPIES.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: import.temporary = Some(temporary.clone());
    // rust: let actual = if clone_file(source, &temporary).is_ok() {
    // rust: digest(&temporary, algorithm)?
    // rust: } else {
    // rust: match algorithm {
    // rust: "sha1" => copy_hash::<sha1::Sha1>(source, &temporary),
    // rust: _ => copy_hash::<sha2::Sha256>(source, &temporary),
}
    // rust: .map_err(|e| format!("{}: {e}", source.display()))?
}
    // rust: if actual != checksum {
    // rust: return Err(format!(
    // rust: "{} is not the pinned file: expected {algorithm} {checksum}, got {actual}",
    // rust: source.display()
    // rust: ));
}
    // rust: Ok(import)
}

    // rust: pub(crate) fn commit(mut self) -> Result<PathBuf, String> {
    // rust: if let Some(temporary) = &self.temporary {
    // rust: fs::rename(temporary, &self.destination)
    // rust: .map_err(|e| format!("{}: {e}", self.destination.display()))?;
}
    // rust: self.temporary = None;
    // rust: Ok(self.destination.clone())
}
}

    // rust: impl Drop for Import {
pub fn drop(self: *Self) void {
}
    // rust: if let Some(temporary) = &self.temporary {
    // rust: let _ = fs::remove_file(temporary);
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn copies_are_independent_and_checked_before_publication() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-file-copy-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let source = dir.join("source");
    // rust: let target = dir.join("target");
    // rust: let data = vec![42; 200_000]; // More than one streaming buffer.
    // rust: fs::write(&source, &data).unwrap();
    // rust: for algorithm in ["sha1", "sha256"] {
    // rust: let checksum = digest(&source, algorithm).unwrap();
    // rust: Import::stage(&source, &target, &checksum, algorithm, false)
    // rust: .unwrap()
    // rust: .commit()
    // rust: .unwrap();
    // rust: assert_eq!(digest(&target, algorithm).unwrap(), checksum);
    // rust: fs::write(&target, b"old destination").unwrap();
    // rust: assert_eq!(fs::read(&source).unwrap(), data);
    // rust: assert!(Import::stage(&source, &target, "bad hash", algorithm, false).is_err());
    // rust: assert_eq!(fs::read(&target).unwrap(), b"old destination");
            // Explicitly exercise ordinary streaming copies even on a reflink filesystem.
    // rust: let streamed = if algorithm == "sha1" {
    // rust: copy_hash::<sha1::Sha1>(&source, &target).unwrap()
    // rust: } else {
    // rust: copy_hash::<sha2::Sha256>(&source, &target).unwrap()
}
    // rust: assert_eq!(streamed, checksum);
    // rust: assert_eq!(fs::read(&target).unwrap(), data);
}
    // rust: clone_or_copy(&source, &target).unwrap();
    // rust: fs::write(&target, b"rewrite").unwrap();
    // rust: assert_eq!(fs::read(&source).unwrap(), data);
    // rust: let staged = Import::stage(
    // rust: &source,
    // rust: &target,
    // rust: &digest(&source, "sha1").unwrap(),
    // rust: "sha1",
    // rust: false,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(fs::read_dir(&dir).unwrap().count(), 3);
    // rust: drop(staged);
    // rust: assert_eq!(fs::read_dir(&dir).unwrap().count(), 2);
    // rust: fs::remove_dir_all(dir).unwrap();
}
}
