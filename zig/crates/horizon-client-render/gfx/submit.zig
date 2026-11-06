//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_submit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The frame's commands finished, submitted and presented on a thread of their own.
//!
//! wgpu records a pass's commands lazily: `CommandEncoder::finish` validates and
//! encodes the whole frame (about 0.1 ms with the submit), work the window's thread
//! would otherwise wait for before building the next frame. The renderer hands the
//! frame's encoder to [`Queue::submit_later`] and goes on; every use of the queue
//! ([`Deref`]) first waits for that frame to be submitted, so writes, copies and
//! submissions keep the order they had on one thread.
// use std::ops::Deref;
// use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
// use std::sync::{Mutex, mpsc};
// use std::time::{Duration, Instant};

/// Whether frames go to the submit thread, unless `HORIZON_SUBMIT_THREAD` says (`0` off, `1` on):
/// on Linux, where it was measured faster (+32% FPS in a CPU-bound view on Vulkan, #5779). On
/// macOS's Metal it stalled: offscreen at render distance 12, a tenth to a half of the frame rate
/// with 20-180 ms p99 frames, against the same binary without it. Windows is not measured yet.
pub fn wanted() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match std::env::var("HORIZON_SUBMIT_THREAD").as_deref() {
    // rust: Ok("0") => false,
    // rust: Ok("1") => true,
    // rust: _ => cfg!(target_os = "linux"),
}
}

/// Work to start right after a frame's submission (a readback's `map_async`).
    // rust: pub type AfterSubmit = Box<dyn FnOnce() + Send>;

/// A frame for the submit thread: its commands and, in a window, the surface to present.
pub const Job = struct {
    encoder: wgpu::CommandEncoder,
    surface: ?wgpu::SurfaceTexture,
    after: ?AfterSubmit,
};

pub const Thread = struct {
    jobs: ?mpsc::Sender<Job>,
    handle: ?std::thread::JoinHandle<()>,
};

/// What the submit thread sent back, once it is taken in by [`Queue::wait`].
pub const Landing = struct {
    done: mpsc::Receiver<wgpu::SubmissionIndex>,
    landed: ?wgpu::SubmissionIndex,
};

/// The device's queue, with frames submitted on the submit thread when it runs.
pub const Queue = struct {
    queue: wgpu::Queue,
    thread: ?Thread,
    /// A frame went to the submit thread and has not been waited for.
    pending: AtomicBool,
    landing: Mutex<?Landing>,
    /// Nanoseconds the window's thread waited for the submit thread since the last
    /// [`take_waited`](Self::take_waited): the GPU or the display holding a frame back, not work.
    waited: AtomicU64,
};

    // rust: impl Queue {
    /// `threaded`: frames may go to a submit thread (the renderer asks [`wanted`]).
pub fn new(queue: wgpu::Queue, threaded: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut this = Self {
    // rust: queue,
    // rust: thread: None,
    // rust: pending: AtomicBool::new(false),
    // rust: landing: Mutex::new(None),
    // rust: waited: AtomicU64::new(0),
}
    // rust: if !threaded {
    // rust: return this;
}
    // rust: let (jobs, job_rx) = mpsc::channel::<Job>();
    // rust: let (done_tx, done) = mpsc::channel();
    // rust: let queue = this.queue.clone();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Render submit".into())
    // rust: .spawn(move || {
    // rust: for job in job_rx {
    // rust: let commands = job.encoder.finish();
    // rust: let submission = queue.submit([commands]);
    // rust: if let Some(after) = job.after {
    // rust: after();
}
    // rust: if let Some(surface) = job.surface {
    // rust: queue.present(surface);
}
    // rust: if done_tx.send(submission).is_err() {
    // rust: break;
}
}
    // rust: });
    // rust: match spawned {
    // rust: Ok(handle) => {
    // rust: this.thread = Some(Thread {
    // rust: jobs: Some(jobs),
    // rust: handle: Some(handle),
    // rust: });
    // rust: *this.lock() = Some(Landing { done, landed: None });
}
    // rust: Err(e) => log::warn!("Horizon renderer: no submit thread ({e}); submitting in place"),
}
    // rust: this
}
pub fn lock(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.landing
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
}
    /// Whether frames can go to the submit thread.
pub fn threaded(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.thread.is_some()
}
    /// Finish, submit and present the frame on the submit thread, then run its `after`;
    /// given back, with nothing done, when there is none.
pub fn submit_later(self: *Self, job: Job) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(jobs) = self.thread.as_ref().and_then(|t| t.jobs.as_ref()) else {
    // rust: return Err(Box::new(job));
}
    // rust: self.wait();
    // rust: match jobs.send(job) {
    // rust: Ok(()) => {
    // rust: self.pending.store(true, Ordering::Release);
    // rust: Ok(())
}
    // rust: Err(mpsc::SendError(job)) => Err(Box::new(job)),
}
}
    /// Wait until the frame on the submit thread is submitted and presented.
pub fn wait(self: *Self) void {
}
    // rust: if !self.pending.load(Ordering::Acquire) {
    // rust: return;
}
    // rust: let mut landing = self.lock();
    // rust: if !self.pending.load(Ordering::Acquire) {
    // rust: return;
}
    // rust: if let Some(l) = landing.as_mut() {
    // rust: let started = Instant::now();
            // A thread that died (a wgpu panic on it) panics here, as it would have in place.
    // rust: let submission = l
    // rust: .done
    // rust: .recv()
    // rust: .expect("Horizon renderer: the submit thread stopped");
    // rust: l.landed = Some(submission);
    // rust: let nanos = u64::try_from(started.elapsed().as_nanos()).unwrap_or(u64::MAX);
    // rust: self.waited.fetch_add(nanos, Ordering::Relaxed);
}
    // rust: self.pending.store(false, Ordering::Release);
}
    /// How long the window's thread waited for the submit thread since the last call: in a
    /// GPU-bound view, the previous frame's submission and present hold up every use of the
    /// queue (uploads in the frame's first half too), and that is waiting, not the frame's work.
pub fn take_waited(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Duration::from_nanos(self.waited.swap(0, Ordering::Relaxed))
}
    /// The submission of the frame [`submit_later`](Self::submit_later) took, once it is
    /// made; `None` if it was taken already.
pub fn landed(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.wait();
    // rust: self.lock().as_mut().and_then(|l| l.landed.take())
}
}

    // rust: impl Deref for Queue {
    // rust: type Target = wgpu::Queue;
pub fn deref(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.wait();
    // rust: &self.queue
}
}

    // rust: impl Drop for Queue {
pub fn drop(self: *Self) void {
}
    // rust: self.wait();
    // rust: if let Some(thread) = &mut self.thread {
    // rust: thread.jobs.take();
    // rust: if let Some(handle) = thread.handle.take() {
    // rust: let _ = handle.join();
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn device() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

pub fn buffer(device: *wgpu::Device, usage: wgpu::BufferUsages) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 4,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: })
}

pub fn writes_after_a_frame_on_the_thread_land_after_it() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let queue = Queue::new(queue, true);
    // rust: assert!(queue.threaded());
//         use wgpu::BufferUsages as U;
    // rust: let source = buffer(&device, U::COPY_SRC | U::COPY_DST);
    // rust: let copy = buffer(&device, U::COPY_SRC | U::COPY_DST);
    // rust: let read = buffer(&device, U::MAP_READ | U::COPY_DST);
    // rust: queue.write_buffer(&source, 0, &[1, 2, 3, 4]);
    // rust: for frame in 0..3u8 {
            // The frame copies `source`; the next frame's write must not reach that copy.
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_buffer_to_buffer(&source, 0, &copy, 0, 4);
    // rust: let job = Job {
    // rust: encoder,
    // rust: surface: None,
    // rust: after: None,
}
    // rust: assert!(queue.submit_later(job).is_ok());
    // rust: queue.write_buffer(&source, 0, &[frame + 10; 4]);
    // rust: assert!(queue.landed().is_some(), "frame {frame} submitted");
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_buffer_to_buffer(&copy, 0, &read, 0, 4);
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let expected = if frame == 0 {
    // rust: [1, 2, 3, 4]
    // rust: } else {
    // rust: [frame + 9; 4]
}
    // rust: assert_eq!(*read.slice(..).get_mapped_range().unwrap(), expected);
    // rust: read.unmap();
}
}
}
