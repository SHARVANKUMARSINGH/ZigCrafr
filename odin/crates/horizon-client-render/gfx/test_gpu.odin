//! Transpiled from Horizon Rust crate
package horizon_client_render_test_gpu

import "core:fmt"
import "core:mem"
import "core:math"

// The GPU tests' `wgpu::Instance`.

// A new instance for one GPU test. On Windows it opens Vulkan and DirectX 12,
// not OpenGL: WGL instances made and dropped from many test threads at once
// deadlocked NVIDIA's driver, and the render tests hung most runs (#5238).
// The game runs there on Vulkan or DirectX 12 unless neither works.
// `WGPU_BACKEND` and the other `WGPU_*` variables still apply, as in the game.
    // rust: pub(crate) fn instance() -> wgpu::Instance {
    // rust: let mut descriptor = wgpu::InstanceDescriptor::new_without_display_handle();
    // rust: if cfg!(windows) {
    // rust: descriptor.backends = wgpu::Backends::PRIMARY;
}
    // rust: wgpu::Instance::new(descriptor.with_env())
}
