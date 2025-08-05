# Multi-stage build for lightweight NASA fuel calculator
FROM elixir:1.18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get --only prod

# Copy source code
COPY lib/ ./lib/

# Build the escript
RUN mix escript.build

# Runtime stage - use Elixir runtime for escript execution
FROM elixir:1.18-alpine

# Create app user
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

# Set working directory
WORKDIR /app

# Copy the built escript from builder stage
COPY --from=builder /app/nasa .

# Make executable
RUN chmod +x nasa

# Switch to non-root user
USER app

# Set the entrypoint
ENTRYPOINT ["./nasa"] 
