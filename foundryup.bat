@echo off

REM Check for foundryup-specific commands
IF [%~1] == [] GOTO install_latest
IF [%~1] == [-h] GOTO usage
IF [%~1] == [--help] GOTO usage
IF [%~1] == [-v] GOTO version
IF [%~1] == [--version] GOTO show_version
IF [%~1] == [-b] GOTO branch
IF [%~1] == [--branch] GOTO branch
IF [%~1] == [-P] GOTO pr
IF [%~1] == [--pr] GOTO pr
IF [%~1] == [-C] GOTO commit
IF [%~1] == [--commit] GOTO commit
IF [%~1] == [-r] GOTO repo
IF [%~1] == [--repo] GOTO repo
IF [%~1] == [-p] GOTO path
IF [%~1] == [--path] GOTO path
IF [%~1] == [-L] GOTO local
IF [%~1] == [--local] GOTO local

GOTO install_latest

:usage
echo foundryup: The Foundry toolchain installer
echo.
echo Usage: foundryup [OPTIONS]
echo.
echo Options:
echo   -h, --help      Print this help message
echo   -v VERSION      Install a specific version
echo   --version       Show the currently installed version
echo   -b, --branch    Install from a specific branch
echo   -P, --pr        Install from a specific PR
echo   -C, --commit    Install from a specific commit
echo   -r, --repo      Install from a custom repo
echo   -p, --path      Install to a custom path
echo   -L, --local     Install from local repository
echo.
echo Common usage:
echo   foundryup              Install/update to latest version
echo   foundryup -v nightly   Install nightly version
echo   foundryup -v 0.2.0     Install specific version
echo   foundryup -b master    Install from master branch
echo   foundryup -P 1234      Install from PR #1234
GOTO done

:install_latest
echo Installing latest Foundry version...
cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil forge cast chisel --bins --locked
GOTO done

:version
echo Installing Foundry version %2...
cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil forge cast chisel --bins --locked --version %2
GOTO done

:show_version
forge --version
cast --version
anvil --version
chisel --version
GOTO done

:branch
echo Installing from branch %2...
cargo install --git https://github.com/foundry-rs/foundry --branch %2 foundry-cli anvil forge cast chisel --bins --locked
GOTO done

:pr
echo Installing from PR #%2...
cargo install --git https://github.com/foundry-rs/foundry --rev refs/pull/%2/head foundry-cli anvil forge cast chisel --bins --locked
GOTO done

:commit
echo Installing from commit %2...
cargo install --git https://github.com/foundry-rs/foundry --rev %2 foundry-cli anvil forge cast chisel --bins --locked
GOTO done

:repo
echo Installing from repository %2...
set REPO=%2
IF [%3] == [-b] (
    cargo install --git %REPO% --branch %4 foundry-cli anvil forge cast chisel --bins --locked
) ELSE (
    cargo install --git %REPO% foundry-cli anvil forge cast chisel --bins --locked
)
GOTO done

:path
echo Custom path installation not fully implemented in batch
echo Please set PATH manually after installation
cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil forge cast chisel --bins --locked --root %2
GOTO done

:local
echo Installing from local repository...
IF [%2] == [] (
    echo Error: Please specify local repository path
    GOTO done
)
cargo install --path %2/cli --bins --locked
cargo install --path %2/anvil --bins --locked
cargo install --path %2/forge --bins --locked
cargo install --path %2/cast --bins --locked
cargo install --path %2/chisel --bins --locked
GOTO done

:done
