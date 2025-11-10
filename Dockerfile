FROM debian:trixie-slim as builder

# Dipendenze di build
RUN apt-get update && \
	apt-get install -y \
	gcc clang git curl libudev-dev \
	libgbm-dev libxkbcommon-dev libegl1-mesa-dev \
	libwayland-dev libinput-dev libdbus-1-dev \
	libsystemd-dev libseat-dev libpipewire-0.3-dev \
	libpango1.0-dev libdisplay-info-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /src

# Clona niri
WORKDIR /src
RUN git clone --branch main https://github.com/YaLTeR/niri.git
WORKDIR /src/niri

# Cartella output
RUN mkdir -p /out

# Compila niri
RUN cargo build --release --no-default-features --features dinit,dbus,xdp-gnome-screencast

# Copia il binario on /out/niri
CMD ["bash", "-c", "cp /src/niri/target/release/niri /out/niri"]
