# Base image for Maven build environment
FROM maven:3.8.1-jdk-8 AS builder

# Set working directory
WORKDIR /app

# Copy application source code
COPY . /app

# Run a dummy test as part of the Maven lifecycle
RUN mvn clean test

# Use Kaniko's debug image as the final image
FROM gcr.io/kaniko-project/executor:debug

# Set the working directory for Kaniko
WORKDIR /workspace

# Copy the application files from the builder stage
COPY --from=builder /app /workspace/app

# Default command for Kaniko
CMD ["sleep", "9999999"]
