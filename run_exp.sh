#!/usr/bin/env bash
set -e

echo "========================================"
echo " Running PQC Experiments "
echo " (Current Directory Based)"
echo "========================================"

# --------- Root directory ----------
ROOT_DIR="$(pwd)"
LIBOQS_BUILD="$ROOT_DIR/libs/liboqs/build"
RESULTS_DIR="$ROOT_DIR/experiments"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTDIR="$RESULTS_DIR/run_$TIMESTAMP"

mkdir -p "$OUTDIR"

echo "[+] Root directory: $ROOT_DIR"
echo "[+] Results directory: $OUTDIR"
echo ""

# --------- Sanity check ----------
if [ ! -d "$LIBOQS_BUILD" ]; then
    echo "[!] liboqs build directory not found!"
    echo "    Run setup_pqc_env.sh first."
    exit 1
fi

# --------- System info ----------
echo "[+] Collecting system info..."
{
    echo "Date: $(date)"
    echo "Kernel: $(uname -a)"
    echo "CPU Information:"
    lscpu
} > "$OUTDIR/system_info.txt"

cd "$LIBOQS_BUILD"

# --------- Kyber KEM benchmarks ----------
echo "[+] Running KEM benchmarks..."
{
    echo "===== KEM SPEED TEST ====="
    ./tests/speed_kem
} > "$OUTDIR/kem_speed.txt"

KEM_ALGS=(
  Kyber512
  Kyber768
  Kyber1024
)

echo "===== KEM FUNCTIONAL TESTS =====" > "$OUTDIR/kem_test.txt"

for alg in "${KEM_ALGS[@]}"; do
    echo "[+] Testing KEM: $alg"
    {
        echo "---- $alg ----"
        ./tests/test_kem "$alg"
        echo ""
    } >> "$OUTDIR/kem_test.txt"
done


# --------- Dilithium signature benchmarks ----------
echo "[+] Running signature benchmarks..."
{
    echo "===== SIGNATURE SPEED TEST ====="
    ./tests/speed_sig
} > "$OUTDIR/sig_speed.txt"


SIG_ALGS=(
  ML-DSA-44
  ML-DSA-65
  ML-DSA-87
)


echo "===== SIGNATURE FUNCTIONAL TESTS =====" > "$OUTDIR/sig_test.txt"

for alg in "${SIG_ALGS[@]}"; do
    echo "[+] Testing SIG: $alg"
    {
        echo "---- $alg ----"
        ./tests/test_sig "$alg"
        echo ""
    } >> "$OUTDIR/sig_test.txt"
done


# --------- Size reference ----------
cat > "$OUTDIR/size_notes.txt" <<EOF
Key and signature sizes are defined in liboqs headers:

- KEM sizes: oqs/kem.h
- Signature sizes: oqs/sig.h

Look for:
  kem->length_public_key
  kem->length_ciphertext
  sig->length_signature
EOF

echo "========================================"
echo " Experiments completed successfully "
echo " Results stored in:"
echo " $OUTDIR"
echo "========================================"
