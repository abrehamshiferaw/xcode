# ===============================================================
# Build image
# ===============================================================

FROM swift:5.5-focal as build
WORKDIR /build

# Copy dependencies first to cache them

COPY ./Package.* ./
RUN swift package resolve

# Copy the rest of the code and build it .

COPY . .
RUN swift build -c release

# =============================================================
# Run image
# =============================================================

FROM swift:5.5-focal-slim
WORKDIR /app

# Copy the compiled executable

COPY --from=build /build/.build/releases/VelvetLeash /app/

# Copy the Leaf HTML templates so the web pages render

COPY --from=build /build/Resources /app/Resources

# Set the environment to production and bind to 0.0.0.0 (Required for Render )

ENTRYPOINT ["./VelvetLeash"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "10000"]
