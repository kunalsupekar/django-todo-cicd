# Use an official Python runtime as a parent image
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /data

# Install distutils to avoid errors during Django installation
RUN apt-get update && apt-get install -y python3-distutils

# Install Django 3.2
RUN pip install django==3.2

# Copy the current directory contents into the container at /data
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port 8000 for the app
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
