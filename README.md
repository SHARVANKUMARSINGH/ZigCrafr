# Zigcraft

<p align="center">
  <b>Minecraft Java Edition reimagined in Zig and Odin</b><br>
  <i>Ported from <a href="https://github.com/horizon-rust/horizon">horizon-rust/horizon</a></i>
</p>

---

## 🌟 Overview

**Zigcraft** is a modern, high-performance reimplementation of Minecraft (Java Edition) utilizing **Zig** for core systems and platform architecture, and **Odin** for procedural world generation, ECS, and gameplay simulation.

### Why Zig and Odin?

- **Zig (Systems & Platform Foundation):**
  - High-performance memory management (Arena, GeneralPurposeAllocator, FixedBuffer).
  - Multithreaded greedy/face-culling voxel chunk mesher generating hardware-optimized vertex buffers.
  - Minecraft protocol engine: VarInt, VarLong, packet framing, Handshake, Status, Login, and Play packets.
  - Full Named Binary Tag (NBT) serializer and deserializer for world saving and network exchange.
  - Android NDK and JNI bindings (`ANativeActivity`, `GLSurfaceView`, touch events).
  - OpenGL ES 3.0 / Vulkan rendering pipeline with GLSL ES 300 shaders.
  - Universal cross-compilation build system (`build.zig`).

- **Odin (World Generation & Gameplay Engine):**
  - Procedural 2D/3D Simplex & Perlin fractal noise generators.
  - Minecraft terrain generator: continental heightmaps, stone/dirt/grass stratigraphy, oceans, sand beaches, 3D cave carving, ore veins (Coal, Iron, Gold, Diamond), and Oak tree canopy decorators.
  - Entity Component System (ECS) and physics engine: AABB collision detection, gravity, jumping, air drag, and ground friction.
  - Inventory and hotbar management (9 slots), health simulation, and 24,000-tick day/night cycle.
  - C ABI interface (`odin_exports.odin`) for zero-overhead interop with Zig.

- **Cubiq-Launcher Touch Controls:**
  - Cloned from [VivxKumar07/Cubiq-Launcher](https://github.com/VivxKumar07/Cubiq-Launcher) (`LayerController`).
  - 186 authentic Minecraft Bedrock/Java edition control button textures.
  - Dynamic analog joystick (`joystick_base.png`, `joystick_handle.png`).
  - Action button cluster (Attack sword, Use/Interact block, Jump, Sneak, Sprint).
  - Top action bar (Chat, Pause, F3 debug overlay, F5 camera perspective, Inventory).
  - 9-slot interactive hotbar, crosshair, and haptic feedback.

---

## 📁 Repository Structure

```
zigcraft/
├── .github/
│   └── workflows/
│       └── build-apk.yml          # GitHub Actions workflow compiling Android APK
├── android/                       # Full Android Studio / Gradle project
│   ├── app/
│   │   ├── build.gradle           # NDK configuration, SDK 35, ABI filters
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml # Fullscreen landscape, GLES 3.0
│   │   │   ├── java/com/zigcraft/app/
│   │   │   │   └── MainActivity.java # Cubiq touch controls, joystick, hotbar, JNI
│   │   │   ├── assets/
│   │   │   │   ├── controls/      # Cubiq Bedrock & Pocket Edition layout JSONs
│   │   │   │   └── shaders/       # GLSL ES 3.0 chunk vertex & fragment shaders
│   │   │   ├── res/drawable/      # 186 authentic Cubiq control button textures
│   │   │   └── jniLibs/           # Bundled libzigcraft.so (arm64, armeabi, x86_64)
│   │   └── proguard-rules.pro
│   ├── build.gradle
│   ├── settings.gradle
│   └── gradlew
├── cubiq_controls/                # Cloned LayerController source and layout configs
├── build.zig                      # Zig build orchestrator (Desktop & Android)
├── libodin.a                      # Compiled Odin runtime & worldgen archive
├── odin/                          # Odin gameplay & procedural systems
│   ├── bridge/
│   │   └── odin_exports.odin      # C ABI exports (worldgen, physics, player)
│   ├── gameplay/
│   │   └── player.odin            # Inventory, hotbar, health, day/night cycle
│   ├── physics/
│   │   └── collision.odin         # AABB voxel physics, jumping, drag
│   ├── worldgen/
│   │   ├── generator.odin         # Minecraft terrain, biomes, ores, trees
│   │   └── noise.odin             # 2D/3D Simplex, Perlin, FBM fractal noise
│   └── crates/                    # 38 Horizon crates converted to Odin modules
├── src/                           # Zig core engine
│   ├── main.zig                   # Desktop entrypoint & tick demonstration
│   ├── android_main.zig           # Android JNI & NativeActivity entrypoint
│   ├── bridge/
│   │   └── odin_bridge.zig        # Zig FFI bindings to Odin C ABI
│   ├── core/
│   │   └── math.zig               # Vec3, Vec3i, Mat4, AABB, Raycasting
│   ├── network/
│   │   ├── nbt.zig                # Full NBT binary tag parser/serializer
│   │   └── protocol.zig           # Minecraft VarInt & packet codec
│   ├── renderer/
│   │   └── gl.zig                 # GLES 3.0 rendering pipeline & shader uniforms
│   └── world/
│       ├── block.zig              # Block definitions, textures, hardness
│       ├── chunk.zig              # 16x256x16 chunk & subchunk storage
│       └── mesher.zig             # Voxel face-culling mesher
├── tools/
│   └── convert_crates.py          # Transpiler converting Horizon crates to Zig & Odin
└── zig/
    └── crates/                    # 38 Horizon crates converted to Zig modules
```

---

## 🚀 Building & Running

### 1. Run Desktop Engine (Zig + Odin)

```bash
# Compile and run Zigcraft
zig build run
```

Sample output:
```text
=========================================
  Zigcraft: Minecraft in Zig & Odin
=========================================
[Zigcraft] Initializing Odin subsystem...
[Zigcraft] Odin initialized successfully.
[Zigcraft] Generating chunk (0, 0) via Odin worldgen...
[Zigcraft] Chunk generated. Non-air sections populated.
[Zigcraft] Meshing chunk with Zig voxel mesher...
[Zigcraft] Mesh complete: 24916 vertices, 37374 indices (12458 triangles)
[Zigcraft] Running physics tick in Odin...
[Zigcraft] Player position after tick: (8.00, 74.93, 8.00), on_ground: false
[Zigcraft] Encoded Minecraft Handshake packet: 16 bytes
[Zigcraft] All Zig & Odin systems operating normally!
```

### 2. Rebuilding Odin Bridge Objects

```bash
odin build odin/bridge -build-mode:obj -no-entry-point -out:odin_bridge.o
zig ar rcs libodin.a odin_bridge-*.o
rm -f odin_bridge-*.o
```

### 3. Re-running Horizon Crate Conversion

```bash
python3 tools/convert_crates.py
```
Converts all 38 Horizon Rust crates (`horizon-core`, `horizon-world`, `horizon-client`, `horizon-protocol`, `horizon-shaders`, etc.) into structured Zig and Odin source packages.

---

## 📱 Android APK Compilation

The repository includes a ready-to-build Android Gradle project with virtual touchscreen controls (analog movement joystick, camera swipe look, jump button, and 9-slot inventory hotbar).

### GitHub Actions CI/CD (`.github/workflows/build-apk.yml`)

The GitHub Actions workflow automates the entire APK build process:
1. Sets up JDK 17, Android SDK & NDK (API 35 / NDK r26).
2. Installs Zig 0.13.0 and Odin.
3. Compiles Odin game logic into static objects.
4. Cross-compiles `libzigcraft.so` for:
   - `arm64-v8a` (64-bit ARM)
   - `armeabi-v7a` (32-bit ARM)
   - `x86_64` (Emulators / ChromeOS)
5. Packages shared libraries into `android/app/src/main/jniLibs/`.
6. Executes `./gradlew assembleDebug` and `./gradlew assembleRelease`.
7. Uploads the compiled APK as a downloadable release artifact (`zigcraft-debug-apk`).

To trigger the build:
- Push to `main`/`master`, open a Pull Request, or click **"Run workflow"** under GitHub Actions!
