#!/bin/bash
#
# compile.sh - Build / Check the Claurst Rust workspace
#
# Usage:
#   ./compile.sh            # Fast check (recommended during development)
#   ./compile.sh release    # Full optimized build
#   ./compile.sh test       # Run tests
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_RUST_DIR="$SCRIPT_DIR/src-rust"

cd "$SRC_RUST_DIR"

echo "==> Working directory: $(pwd)"
echo "==> Rust version: $(rustc --version)"
echo ""

case "${1:-check}" in
    check|"")
        echo "==> Running: cargo check --workspace"
        cargo check --workspace
        echo ""
        echo "✅ Check passed successfully."
        ;;

    build|release)
        echo "==> Running: cargo build --release --workspace"
        cargo build --release --workspace
        echo ""
        echo "✅ Release build completed."
        echo "   Binaries are in: target/release/"
        ;;

    test)
        echo "==> Running: cargo test --workspace"
        cargo test --workspace
        echo ""
        echo "✅ All tests passed."
        ;;

    clippy)
        echo "==> Running: cargo clippy --workspace --all-targets -- -D warnings"
        cargo clippy --workspace --all-targets -- -D warnings
        echo ""
        echo "✅ Clippy passed with no warnings."
        ;;

    fmt)
        echo "==> Running: cargo fmt --all -- --check"
        cargo fmt --all -- --check
        echo ""
        echo "✅ Formatting is correct."
        ;;

    *)
        echo "Unknown command: $1"
        echo ""
        echo "Usage:"
        echo "  ./compile.sh            # Fast check (default)"
        echo "  ./compile.sh release    # Full release build"
        echo "  ./compile.sh test       # Run all tests"
        echo "  ./compile.sh clippy     # Run clippy with strict warnings"
        echo "  ./compile.sh fmt        # Check formatting"
        exit 1
        ;;
esac