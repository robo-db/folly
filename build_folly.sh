#!/bin/bash
# Build script for Facebook Folly library
# This script automates the build process for Folly using getdeps.py

set -e  # Exit on error

echo "=========================================="
echo "Folly Build Script"
echo "=========================================="
echo ""

# Check Python version
echo "Checking Python version..."
PYTHON_VERSION=$(python3 --version)
echo "Found: $PYTHON_VERSION"
echo "Required: Python 3.6 or newer"
echo ""

# Check if we're in the folly directory
if [ ! -f "build/fbcode_builder/getdeps.py" ]; then
    echo "Error: build/fbcode_builder/getdeps.py not found"
    echo "Please run this script from the folly root directory"
    exit 1
fi

echo "=========================================="
echo "Step 1: Install System Dependencies (Optional)"
echo "=========================================="
echo ""
echo "To install system dependencies (requires sudo):"
echo "  sudo ./build/fbcode_builder/getdeps.py install-system-deps --recursive"
echo ""
echo "To see what would be installed without installing:"
echo "  ./build/fbcode_builder/getdeps.py install-system-deps --dry-run --recursive"
echo ""
echo "Skipping system dependency installation (requires sudo privileges)."
echo "getdeps.py will download and build missing dependencies automatically."
echo ""

echo "=========================================="
echo "Step 2: Build Folly"
echo "=========================================="
echo ""
echo "Starting build process..."
echo "This may take 20-60 minutes depending on your system."
echo "The script will:"
echo "  1. Download and build Boost 1.83.0"
echo "  2. Download and build other dependencies (gflags, glog, fmt, etc.)"
echo "  3. Build Folly itself"
echo ""

# Build Folly
python3 ./build/fbcode_builder/getdeps.py --allow-system-packages build

echo ""
echo "=========================================="
echo "Build Complete!"
echo "=========================================="
echo ""

# Show build and install directories
BUILD_DIR=$(python3 ./build/fbcode_builder/getdeps.py show-build-dir)
INSTALL_DIR=$(python3 ./build/fbcode_builder/getdeps.py show-inst-dir)

echo "Build directory:   $BUILD_DIR"
echo "Install directory: $INSTALL_DIR"
echo ""
echo "Static library: $INSTALL_DIR/lib/libfolly.a"
echo ""
echo "To use Folly in your project, add to your CMake:"
echo "  set(CMAKE_PREFIX_PATH \"$INSTALL_DIR\")"
echo "  find_package(folly CONFIG REQUIRED)"
echo "  target_link_libraries(your_target folly)"
echo ""

echo "=========================================="
echo "Optional: Run Tests"
echo "=========================================="
echo ""
echo "To run Folly tests:"
echo "  python3 ./build/fbcode_builder/getdeps.py --allow-system-packages test"
echo ""
