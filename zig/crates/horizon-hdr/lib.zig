//! Transpiled from Horizon Rust crate
//! Module: horizon-hdr_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! HDR metadata for the swapchain: the Vulkan calls the game crate, which
//! forbids unsafe code, can't make itself. wgpu sets no HDR metadata, and
//! without it a compositor may clip or tone-map everything above 1.0 (80 nits)
//! of an scRGB swapchain.

    // rust: pub mod wayland;

/// Opens a Vulkan device with `VK_EXT_hdr_metadata` too, when the GPU offers
/// it, so [`set_metadata`] can tell the compositor the real peak brightness.
/// `None` leaves opening to wgpu.
    // rust: pub fn open_vulkan_device(
    // rust: adapter: &wgpu::Adapter,
    // rust: desc: &wgpu::DeviceDescriptor<'_>,
    // rust: ) -> Option<Result<(wgpu::Device, wgpu::Queue), wgpu::RequestDeviceError>> {
//     use wgpu::hal::api::Vulkan;
    // rust: let open = {
        // Safety: only read and opened from here; dropped before wgpu takes it back.
    // rust: let hal = unsafe { adapter.as_hal::<Vulkan>() }?;
    // rust: let instance = hal.shared_instance().raw_instance();
        // Safety: the adapter's own physical device on its own instance.
    // rust: let offered =
    // rust: unsafe { instance.enumerate_device_extension_properties(hal.raw_physical_device()) }
    // rust: .ok()?
    // rust: .iter()
    // rust: .any(|e| e.extension_name_as_c_str() == Ok(ash::ext::hdr_metadata::NAME));
    // rust: if !offered {
    // rust: return None;
}
        // Safety: what wgpu's own request_device does, with one more extension.
    // rust: unsafe {
    // rust: hal.open_with_callback(
    // rust: desc.required_features,
    // rust: &desc.required_limits,
    // rust: &desc.memory_hints,
    // rust: Some(Box::new(
    // rust: |args: wgpu::hal::vulkan::CreateDeviceCallbackArgs| {
    // rust: args.extensions.push(ash::ext::hdr_metadata::NAME);
    // rust: },
    // rust: )),
    // rust: )
}
    // rust: .ok()?
}
    // Safety: opened from this adapter with exactly `desc`'s features.
    // rust: Some(unsafe { adapter.create_device_from_hal(open, desc) })
}

/// Tells the compositor, through `VK_EXT_hdr_metadata`, that the swapchain's
/// content is BT.709, peaks at `peak` nits and is no darker than `black`. Needs a
/// device from `open_vulkan_device` and a configured surface; does nothing otherwise.
    // rust: pub fn set_metadata(
    // rust: device: &wgpu::Device,
    // rust: surface: &wgpu::Surface<'_>,
    // rust: paper_white: f32,
    // rust: peak: f32,
    // rust: black: f32,
    // rust: ) {
    // rust: {
//         use wgpu::hal::api::Vulkan;
        // Safety: read-only access to handles wgpu keeps alive while these guards live.
    // rust: let (Some(hal_device), Some(hal_surface)) =
    // rust: (unsafe { device.as_hal::<Vulkan>() }, unsafe {
    // rust: surface.as_hal::<Vulkan>()
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: if !hal_device
    // rust: .enabled_device_extensions()
    // rust: .contains(&ash::ext::hdr_metadata::NAME)
    // rust: {
    // rust: return;
}
    // rust: let Some(swapchain) = hal_surface.raw_native_swapchain() else {
    // rust: return;
}
    // rust: let xy = |x, y| ash::vk::XYColorEXT { x, y };
    // rust: let metadata = ash::vk::HdrMetadataEXT::default()
    // rust: .display_primary_red(xy(0.64, 0.33))
    // rust: .display_primary_green(xy(0.30, 0.60))
    // rust: .display_primary_blue(xy(0.15, 0.06))
    // rust: .white_point(xy(0.3127, 0.3290))
    // rust: .max_luminance(peak)
    // rust: .min_luminance(black)
    // rust: .max_content_light_level(peak)
    // rust: .max_frame_average_light_level(paper_white.min(peak));
    // rust: let loader = ash::ext::hdr_metadata::Device::new(
    // rust: hal_device.shared_instance().raw_instance(),
    // rust: hal_device.raw_device(),
    // rust: );
        // Safety: a live swapchain of this device, one metadata entry for it.
    // rust: unsafe { loader.set_hdr_metadata(&[swapchain], &[metadata]) };
}
    // rust: let _ = (device, surface, paper_white, peak, black);
}
