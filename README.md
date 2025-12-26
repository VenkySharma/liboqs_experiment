# Post-Quantum Cryptography Experiments

## Minimal Requirements and Experiment Scope

This repository provides a **minimal setup and execution framework** to build, run, and evaluate post-quantum **Key Encapsulation Mechanisms (KEMs)** and **Digital Signature (SIG)** algorithms using **liboqs**.

The focus is on **implementation, experimentation, and benchmarking**, following standard liboqs methods.

---
## Contents
- `setup_env.sh` – environment setup script
- `run_exp.sh` – experiment runner
- `experiments/` – benchmark results and system info

## Setup and Execution Flow

### 1. Environment Setup

The script `setup_env.sh` installs all required dependencies and builds `liboqs` locally.

```bash
./setup_env.sh

### 2. Running Experiments

The script run_exp.sh runs the post-quantum experiments:

./run_exp.sh

This script performs:

    Speed benchmarking for all enabled KEM and signature algorithms

    Functional correctness tests for a selected subset of algorithms

Speed vs Functional Testing

    Speed tests (speed_kem, speed_sig) are executed for all enabled algorithms, as supported by liboqs.

    Functional tests (test_kem, test_sig) require an explicit algorithm name.

        By default, only a small representative subset of algorithms is tested.

        Users can modify the algorithm lists directly in run_exp.sh to include additional algorithms.

This behavior follows the standard liboqs testing model.
Customization and Extension

Users are encouraged to:

    Modify algorithm selections in run_exp.sh

    Adjust compiler flags or build options

    Add new experiments following liboqs conventions

These experiments can be used to study how post-quantum algorithms behave on different systems and hardware configurations.
Reproducibility and Limitations

    Performance results are system-dependent (CPU, compiler, operating system, and microarchitecture).

    This repository focuses on benchmarking and behavior observation, not cryptographic security proofs.

    Results should be used for comparative and experimental purposes only.

Security and Privacy

No private keys, credentials, packet captures, or sensitive system identifiers are included.

Only minimal, non-sensitive system information is collected to aid reproducibility.
Tested With

    liboqs v0.15.0

    Ubuntu 24.04

    GCC / Clang

Disclaimer

This repository is intended for research and experimentation only and is not production-ready.
