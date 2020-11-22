# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

set shell := ["/bin/bash", "-c"]

name                    := "url"
log_level               := "debug"
log                     := name + "=" + log_level
prefix                  := env_var("HOME") + "/.cargo"
app_args                := "foo%20bar"
cargo_sub_options       := ""

export RUST_LOG := log
export RUST_BACKTRACE := "1"

alias b := build
alias r := run
alias c := check
alias t := test
alias l := lint

# Execute a main.rs
run:
	cargo run {{ cargo_sub_options }} {{ app_args }}

# Run the tests
test:
	cargo test {{ cargo_sub_options }} -- --nocapture

# Check syntax, but don't build object files
check:
	cargo check {{ cargo_sub_options }}

# Build all project
build:
	cargo build {{ cargo_sub_options }}

# Build all project
release-build:
	just cargo_sub_options="--release" build

# Remove the target directory
clean:
	cargo clean

# Install to $(prefix) directory
install:
	cargo install --force --root {{ prefix }} --path .

# Run fmt
fmt:
	cargo fmt

# Run clippy
clippy:
	cargo clippy

# Run fmt and clippy
lint: fmt clippy
