# Post-Quantum Cryptography Experiments

This repository contains reproducible experiments evaluating
post-quantum cryptographic algorithms using liboqs.

## Contents
- `setup_pqc_env.sh` – environment setup script
- `run_pqc_experiments.sh` – experiment runner
- `experiments/` – benchmark results and system info

## Algorithms Evaluated
- ML-KEM (Kyber)
- ML-DSA (Dilithium)

## Security & Privacy
No private keys, secrets, packet captures, or credentials are included.
System information is limited to CPU and kernel details only.

## Reproducibility
All experiments can be reproduced by running:

```bash
./setup_pqc_env.sh
./run_pqc_experiments.sh
