#!/usr/bin/env bash
# prune-caches.sh — Prune uv, npm, pnpm, Rust (cargo), Go, Ruby (gem), and Zig caches
# Usage: ./prune-caches.sh [--dry-run]
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

hr() { printf '%*s\n' "${COLUMNS:-72}" '' | tr ' ' '─'; }

log_section() { echo -e "\n${BOLD}${CYAN}▶ $1${RESET}"; hr; }
log_ok()      { echo -e "  ${GREEN}✔${RESET}  $1"; }
log_skip()    { echo -e "  ${YELLOW}⚠${RESET}  $1"; }
log_err()     { echo -e "  ${RED}✘${RESET}  $1"; }

run() {
  # $1 = description, rest = command
  local desc="$1"; shift
  if $DRY_RUN; then
    echo -e "  ${YELLOW}[dry-run]${RESET} $desc → would run: $*"
    return 0
  fi
  if "$@" 2>&1 | sed 's/^/    /'; then
    log_ok "$desc"
  else
    log_err "$desc failed (exit $?)"
  fi
}

size_of() {
  # Print human-readable size of a path (silent if missing)
  local path="$1"
  [[ -e "$path" ]] && du -sh "$path" 2>/dev/null | awk '{print $1}' || echo "n/a"
}

echo -e "\n${BOLD}Cache Pruner${RESET}  $(date '+%Y-%m-%d %H:%M:%S')"
$DRY_RUN && echo -e "${YELLOW}  DRY-RUN mode — no changes will be made${RESET}"

# ── uv ────────────────────────────────────────────────────────────────────────
log_section "uv"
if command -v uv &>/dev/null; then
  UV_CACHE_DIR="$(uv cache dir 2>/dev/null || echo "${XDG_CACHE_HOME:-$HOME/.cache}/uv")"
  echo "  Cache dir : $UV_CACHE_DIR  ($(size_of "$UV_CACHE_DIR"))"
  run "uv cache prune" uv cache prune
else
  log_skip "uv not found — skipping"
fi

# ── npm ───────────────────────────────────────────────────────────────────────
log_section "npm"
if command -v npm &>/dev/null; then
  NPM_CACHE="$(npm config get cache 2>/dev/null || echo "$HOME/.npm")"
  echo "  Cache dir : $NPM_CACHE  ($(size_of "$NPM_CACHE"))"
  run "npm cache verify (prune + integrity check)" npm cache verify
else
  log_skip "npm not found — skipping"
fi

# ── pnpm ──────────────────────────────────────────────────────────────────────
log_section "pnpm"
if command -v pnpm &>/dev/null; then
  PNPM_STORE="$(pnpm store path 2>/dev/null || echo "unknown")"
  echo "  Store dir : $PNPM_STORE  ($(size_of "$PNPM_STORE"))"
  run "pnpm store prune (remove unreferenced packages)" pnpm store prune
else
  log_skip "pnpm not found — skipping"
fi

# ── Rust / Cargo ──────────────────────────────────────────────────────────────
log_section "Rust / Cargo"
if command -v cargo &>/dev/null; then
  CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
  CARGO_REGISTRY="$CARGO_HOME/registry"
  CARGO_GIT="$CARGO_HOME/git"

  echo "  CARGO_HOME     : $CARGO_HOME"
  echo "  registry cache : $(size_of "$CARGO_REGISTRY")"
  echo "  git cache      : $(size_of "$CARGO_GIT")"

  # Prefer cargo-cache if available (gives a proper --autoclean)
  if command -v cargo-cache &>/dev/null || cargo cache --version &>/dev/null 2>&1; then
    run "cargo cache --autoclean (remove old artefacts)" \
      cargo cache --autoclean
  else
    # Fallback: trim target artefacts using cargo's built-in sweep if available,
    # otherwise just clean old registry src checkouts (safe to remove — cargo
    # re-downloads them on demand).
    if cargo sweep --version &>/dev/null 2>&1; then
      run "cargo sweep --time 30 (remove artefacts older than 30 days)" \
        cargo sweep --time 30
    else
      log_skip "cargo-cache and cargo-sweep not installed"
      echo "    Install cargo-cache for full pruning:"
      echo "      cargo install cargo-cache"
      echo "    Or cargo-sweep for time-based cleanup:"
      echo "      cargo install cargo-sweep"

      # Safe manual fallback: remove registry *src* unpacks (not index/cache)
      REGISTRY_SRC="$CARGO_REGISTRY/src"
      if [[ -d "$REGISTRY_SRC" ]]; then
        echo "  Fallback : removing registry/src unpacks  ($(size_of "$REGISTRY_SRC"))"
        run "rm -rf $REGISTRY_SRC (re-downloadable source unpacks)" \
          rm -rf "$REGISTRY_SRC"
      fi
    fi
  fi
else
  log_skip "cargo not found — skipping"
fi

# ── Go ────────────────────────────────────────────────────────────────────────
log_section "Go"
if command -v go &>/dev/null; then
  GOPATH="${GOPATH:-$HOME/go}"
  GO_MODCACHE="${GOMODCACHE:-$GOPATH/pkg/mod}"
  GO_CACHE="$(go env GOCACHE 2>/dev/null || echo "${XDG_CACHE_HOME:-$HOME/.cache}/go/build")"

  echo "  Module cache : $GO_MODCACHE  ($(size_of "$GO_MODCACHE"))"
  echo "  Build cache  : $GO_CACHE  ($(size_of "$GO_CACHE"))"

  # go clean -modcache removes ALL module downloads — files are read-only so
  # Go chmod's them writable before deletion. Safe; re-downloaded on next build.
  run "go clean -modcache (remove all downloaded modules)" \
    go clean -modcache

  # go clean -cache removes the build/test cache. Rebuilds are slower afterward
  # but all outputs are reproducible.
  run "go clean -cache (remove build & test cache)" \
    go clean -cache

  # go clean -fuzzcache removes fuzz corpus entries generated during testing.
  run "go clean -fuzzcache (remove fuzz test cache)" \
    go clean -fuzzcache
else
  log_skip "go not found — skipping"
fi

# ── Ruby / Gem ────────────────────────────────────────────────────────────────
log_section "Ruby / Gem"
if command -v gem &>/dev/null; then
  GEM_HOME="$(gem environment gemdir 2>/dev/null || echo "unknown")"
  GEM_CACHE="$GEM_HOME/cache"
  echo "  GEM_HOME    : $GEM_HOME"
  echo "  Gem cache   : $(size_of "$GEM_CACHE")  (downloaded .gem files)"

  # gem cleanup removes all but the latest version of each installed gem.
  # It does NOT remove the latest version, so it's safe to run unconditionally.
  run "gem cleanup (remove old gem versions)" \
    gem cleanup

  # Remove the gem download cache (the .gem tarballs, not the installed gems).
  # They're re-downloaded on demand if needed.
  if [[ -d "$GEM_CACHE" ]]; then
    echo "  Gem download cache : $(size_of "$GEM_CACHE")"
    run "rm -rf $GEM_CACHE (remove cached .gem downloads)" \
      rm -rf "$GEM_CACHE"
  fi

  # Bundler cache — ~/.bundle/cache or $BUNDLE_PATH/cache
  BUNDLE_CACHE="${BUNDLE_PATH:-$HOME/.bundle}/cache"
  if [[ -d "$BUNDLE_CACHE" ]]; then
    echo "  Bundler cache : $BUNDLE_CACHE  ($(size_of "$BUNDLE_CACHE"))"
    run "rm -rf $BUNDLE_CACHE (remove cached bundler gems)" \
      rm -rf "$BUNDLE_CACHE"
  fi
else
  log_skip "gem not found — skipping"
fi

# ── Zig ───────────────────────────────────────────────────────────────────────
log_section "Zig"
if command -v zig &>/dev/null; then
  # Zig's global cache dir: $ZIG_GLOBAL_CACHE_DIR, falling back to the
  # XDG cache location zig itself uses when the env var is unset.
  ZIG_CACHE_DIR="${ZIG_GLOBAL_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/zig}"

  echo "  Global cache : $ZIG_CACHE_DIR  ($(size_of "$ZIG_CACHE_DIR"))"

  # Zig has no built-in prune command yet (as of 0.13). The cache is structured
  # as content-addressed subdirs (h/, o/, tmp/) — all entries are reproducible.
  # Subdirs:
  #   h/   — hash-keyed compilation artefacts (safe to remove)
  #   o/   — object file artefacts             (safe to remove)
  #   tmp/ — in-progress build temporaries     (safe to remove)
  #   z/   — downloaded package tarballs (zig fetch) — safe; re-fetched on demand
  if [[ -d "$ZIG_CACHE_DIR" ]]; then
    for subdir in h o tmp z; do
      target="$ZIG_CACHE_DIR/$subdir"
      if [[ -d "$target" ]]; then
        echo "  $subdir/  : $(size_of "$target")"
        run "rm -rf $target (zig cache/$subdir)" rm -rf "$target"
      fi
    done
  else
    log_skip "Zig cache dir not found at $ZIG_CACHE_DIR — nothing to clean"
  fi

  # Per-project zig-cache dirs — common in monorepos. Remove from CWD if present.
  LOCAL_ZIG_CACHE="$(pwd)/zig-cache"
  if [[ -d "$LOCAL_ZIG_CACHE" ]]; then
    echo "  Local project cache : $LOCAL_ZIG_CACHE  ($(size_of "$LOCAL_ZIG_CACHE"))"
    run "rm -rf $LOCAL_ZIG_CACHE (local zig-cache)" rm -rf "$LOCAL_ZIG_CACHE"
  fi
else
  log_skip "zig not found — skipping"
fi

# ── Not covered (add a section if you use these) ──────────────────────────────
log_section "Not covered by this script"
cat <<'EOF'
  The following have cleanable caches but are out of scope here.
  Add a section above if relevant to your stack:

  Java / Maven   →  rm -rf ~/.m2/repository          (re-downloaded by mvn)
  Java / Gradle  →  gradle --stop && rm -rf ~/.gradle/caches
  .NET / NuGet   →  dotnet nuget locals all --clear
  PHP / Composer →  composer clear-cache
  Swift / SPM    →  rm -rf ~/Library/Caches/org.swift.swiftpm
                    (Linux: ~/.cache/org.swift.swiftpm)
  Haskell / Cabal → cabal clean  (per-project)
                    rm -rf ~/.cabal/packages ~/.cabal/store (global)
  Haskell / Stack → stack clean  (per-project)
                    stack purge  (remove entire stack root — destructive)
  Erlang / Hex   →  mix local.hex --force && rm -rf ~/.hex
  Julia          →  julia -e 'using Pkg; Pkg.gc()'
  Dart / Pub     →  dart pub cache clean
  OCaml / opam   →  opam clean --logs --repo-cache --download-cache
EOF

# ── Summary ───────────────────────────────────────────────────────────────────
echo ""
hr
echo -e "${BOLD}Done.${RESET}  Run again without ${YELLOW}--dry-run${RESET} to apply changes."
echo ""
