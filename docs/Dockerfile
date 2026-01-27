# Use the official Bun image
FROM oven/bun:latest

# Set the working directory
WORKDIR /docs

# Copy the rest of the application code
COPY ./docs .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["bun", "run", "swagger-server.js"]