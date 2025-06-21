# Build stage - download and extract the binary
FROM alpine:latest AS builder

# Install tools needed for download/extraction
RUN apk add --no-cache zstd curl

# Download and extract the edit binary
RUN curl -L https://github.com/microsoft/edit/releases/download/v1.2.0/edit-1.2.0-aarch64-linux-gnu.tar.zst -o /tmp/edit.tar.zst \
    && zstd -d /tmp/edit.tar.zst \
    && tar -xf /tmp/edit.tar -C /tmp/ \
    && chmod +x /tmp/edit

# Final runtime stage - minimal image
FROM alpine:latest

# Install only runtime dependencies
RUN apk add --no-cache \
    gcompat \
    libgcc \
    && rm -rf /var/cache/apk/*

# Copy the binary from build stage
COPY --from=builder /tmp/edit /usr/local/bin/edit

# Set working directory
WORKDIR /workspace

# Set the edit binary as the entrypoint
ENTRYPOINT ["/usr/local/bin/edit"]

# Default to current directory if no args provided
CMD ["."]
