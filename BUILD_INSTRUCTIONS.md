# Folly Build Instructions

## Quick Start

The easiest way to build Folly is using the provided build script:

```bash
cd /home/karthik/github/rock4t/folly
./build_folly.sh
```

## Requirements

- **Python:** 3.6 or newer
- **Compiler:** GCC 5.1+, Clang, or MSVC with C++17 support
- **Platform:** Linux (x86-32/64, ARM), macOS, iOS, or Windows

## Build Methods

### Method 1: Using build_folly.sh Script (Recommended)

```bash
./build_folly.sh
```

This script will:
1. Check Python version
2. Automatically download and build all dependencies
3. Build Folly as a static library

### Method 2: Using getdeps.py Directly

#### Step 1: Install System Dependencies (Optional)

Check what would be installed:
```bash
./build/fbcode_builder/getdeps.py install-system-deps --dry-run --recursive
```

Install system dependencies (requires sudo):
```bash
sudo ./build/fbcode_builder/getdeps.py install-system-deps --recursive
```

#### Step 2: Build Folly

```bash
python3 ./build/fbcode_builder/getdeps.py --allow-system-packages build
```

#### Step 3: Run Tests (Optional)

```bash
python3 ./build/fbcode_builder/getdeps.py --allow-system-packages test
```

### Method 3: Using CMake Directly

If you want more control over the build:

```bash
mkdir _build
cd _build
cmake ..
make -j$(nproc)
sudo make install  # Optional
```

**Note:** You'll need to manually install all dependencies first.

## Build Output

After a successful build:

- **Static Library:** `installed/folly/lib/libfolly.a`
- **Build Directory:** Use `python3 ./build/fbcode_builder/getdeps.py show-build-dir`
- **Install Directory:** Use `python3 ./build/fbcode_builder/getdeps.py show-inst-dir`

## Using Folly in Your Project

### With CMake

```cmake
# Set the path to Folly installation
set(CMAKE_PREFIX_PATH "/path/to/folly/install/dir")

# Find Folly
find_package(folly CONFIG REQUIRED)

# Link against Folly
target_link_libraries(your_target PRIVATE folly)
```

### Get Installation Directory

```bash
python3 ./build/fbcode_builder/getdeps.py show-inst-dir
```

## Build Time

- **First build:** 20-60 minutes (needs to build Boost and other dependencies)
- **Subsequent builds:** Much faster (dependencies are cached)

## Dependencies Built Automatically

getdeps.py will automatically download and build:

- Boost 1.83.0 (with C++14 support)
- gflags
- glog
- fmt
- double-conversion
- libevent
- And other required libraries

## Troubleshooting

### Build Fails

1. Make sure Python 3.6+ is installed: `python3 --version`
2. Check compiler version (GCC >= 5.1 or Clang >= 10)
3. Ensure you have enough disk space (need ~5-10 GB for build)

### Out of Memory

If build runs out of memory, you can limit parallelism:
- The build will use available CPU cores automatically
- On systems with limited RAM, the build may take longer

### Clean Build

To start fresh:
```bash
# Remove build and install directories
rm -rf /tmp/fbcode_builder_getdeps-*
```

## Additional Options

### Specify Scratch Directory

```bash
python3 ./build/fbcode_builder/getdeps.py build --scratch-path /custom/path
```

### Build in Debug Mode

By default, builds are in release mode. For debug builds, you'll need to modify the build manifest or use CMake directly.

## Platform-Specific Notes

### Ubuntu/Debian
System dependencies that can be installed:
```bash
sudo apt-get install autoconf automake binutils-dev cmake \
  libboost-all-dev libdouble-conversion-dev libdwarf-dev \
  libevent-dev libgflags-dev libgmock-dev libgtest-dev \
  liblz4-dev libsnappy-dev libsodium-dev libtool \
  libzstd-dev ninja-build zlib1g-dev zstd
```

### macOS
```bash
brew install folly
```

Or build from source using the same instructions above.

## More Information

- Full documentation: See README.md in the root directory
- Official repository: https://github.com/facebook/folly
