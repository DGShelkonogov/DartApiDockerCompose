# Use the official Dart SDK image as the base image
FROM dart:2.18.6-sdk

# Set the working directory to /app
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock files to the container
COPY pubspec.yaml .
COPY pubspec.lock .

# Get the dependencies for the application
RUN dart pub get

# Copy the rest of the application code to the container
COPY . .

# Compile the Dart code to a kernel snapshot
RUN dart compile kernel bin/api.dart -o /app/api.snapshot

# Run the application using the kernel snapshot
CMD ["dart", "/app/api.snapshot"]

