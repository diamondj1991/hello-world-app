# Stage 1: Build Stage (Used only to install dependencies)
FROM python:3.11-slim AS builder

# Set working directory inside the container
WORKDIR /tmp/deps

# Copy dependency file first (for effective Docker caching)
COPY requirements.txt .

# Install dependencies into a known location (/usr/local/lib/python3.11/site-packages is default)
RUN pip install --no-cache-dir -r requirements.txt


# Stage 2: Final minimal image
# Use the same base image for consistency
FROM python:3.11-slim

# Force the stdout and stderr streams to be unbuffered
ENV PYTHONUNBUFFERED=1

# Set the working directory for the application
WORKDIR /app

# Expose the default Flask port
EXPOSE 5000

# Copy the installed packages from the builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

# Copy the application code from the local ./src directory into the /app directory in the container
COPY src/app.py .

# Create a non-root user and switch to it for better security (best practice)
# In a real enterprise app, you'd use a specific GID/UID
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# Command to execute when the container starts.
# Use Python to run the Flask module to avoid any error about 'flask' executable not being in the $PATH as a non-root user (appuser)
# The --host=0.0.0.0 is critical so the app is reachable from outside the container
CMD ["python3", "-m", "flask", "--app", "app", "run", "--host=0.0.0.0"]

# Manual testing steps
# 1) build: `docker build -t hello-world-app:latest .` (-t tags the image with a name, . specifies that the Dockerfile is in the current directory)
# 2) run: The image is built, so we can run a new container `docker run -p 5000:5000 hello-world-app:latest`
