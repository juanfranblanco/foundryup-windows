@echo off
IF [%~1] == [-v] GOTO version
cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil forge cast --bins --locked
GOTO done
:version
cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil forge cast --bins --locked --version %2

:done
