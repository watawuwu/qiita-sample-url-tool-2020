# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

set shell := ["/bin/bash", "-c"]

name              := "url"
log_level         := "debug"
log               := name + "=" + log_level
prefix            := env_var("HOME") + "/.cargo"
cargo_sub_options := ""
app_args          := "foo%20bar"

export RUST_LOG := log
export RUST_BACKTRACE := "1"

alias b := build
alias r := run
alias c := check
alias t := test
alias l := lint

# Execute a main.rs
run args=app_args opt=cargo_sub_options:
	cargo run {{ opt }} -- {{ args }}

# Run the tests
test opt=cargo_sub_options:
	cargo test {{ opt }} -- --nocapture

# Check syntax, but don't build object files
check opt=cargo_sub_options:
	cargo check {{ opt }}

# Build all project
build opt=cargo_sub_options:
	cargo build {{ opt }}

# Build all project
release-build:
	just build --release

# Remove the target directory
clean:
	cargo clean

# Install to $(prefix) directory
install pre=prefix:
	cargo install --force --root {{ pre }} --path .

# Run fmt
fmt:
	cargo fmt

# Run clippy
clippy:
	cargo clippy

# Run fmt and clippy
lint: fmt clippy
