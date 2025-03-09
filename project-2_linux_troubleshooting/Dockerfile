# Use an official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir flask

# Make sure scripts are executable
RUN chmod +x scripts/*.sh

# Expose the Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "server.py"]
