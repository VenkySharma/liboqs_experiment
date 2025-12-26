#!/usr/bin/env bash
set -e

echo "========================================"
echo " Post-Quantum Cryptography Setup Script "
echo " (Current Directory Based)"
echo "========================================"

# --------- Root directory ----------
ROOT_DIR="$(pwd)"
LIB_DIR="$ROOT_DIR/libs"

echo "[+] Root directory: $ROOT_DIR"

# --------- System update ----------
echo "[+] Updating system packages..."
sudo apt update

# --------- Install dependencies ----------
echo "[+] Installing dependencies..."
sudo apt install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    libssl-dev \
    pkg-config \
    python3 \
    python3-pip \
    clang \
    valgrind \
    curl \
    unzip

# --------- Workspace setup ----------
echo "[+] Creating local workspace structure..."
mkdir -p "$LIB_DIR"

# --------- Clone liboqs ----------
cd "$LIB_DIR"
if [ ! -d "liboqs" ]; then
    echo "[+] Cloning liboqs..."
    git clone https://github.com/open-quantum-safe/liboqs.git
else
    echo "[+] liboqs already exists, updating..."
    cd liboqs
    git pull
    cd ..
fi

# --------- Build liboqs ----------
echo "[+] Building liboqs..."
cd "$LIB_DIR/liboqs"
mkdir -p build
cd build

cmake -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DOQS_USE_OPENSSL=ON \
    ..

ninja

# --------- Run basic tests ----------
echo "[+] Running liboqs tests..."

./tests/test_kem Kyber768
./tests/test_kem ML-KEM-768

./tests/test_sig ML-DSA-44
./tests/test_sig ML-DSA-65


echo "========================================"
echo " Setup completed successfully "
echo " liboqs built in: $LIB_DIR/liboqs/build"
echo "========================================"
