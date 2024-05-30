# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the src directory to the working directory
COPY src/ /app

# Copy the tests directory to the working directory
COPY tests/ /app/tests

# Install dependencies (if any), for now, there are none
# RUN pip install -r requirements.txt

# Run the unit tests
RUN python -m unittest discover tests

# Define the command to run the application
CMD ["python", "-m", "unittest", "discover", "tests"]
