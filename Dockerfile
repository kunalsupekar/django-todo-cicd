# Use an official Python runtime as a parent image
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /data

# Install distutils to avoid errors during Django installation
RUN apt-get update && apt-get install -y python3-distutils

# Install virtualenv
RUN pip install virtualenv

# Create a virtual environment
RUN virtualenv /env

# Activate the virtual environment
ENV PATH="/env/bin:$PATH"

# Install Django 3.2 in the virtual environment
RUN pip install django==3.2

# Copy the current directory contents into the container at /data
COPY . .

# Run migrations within the virtual environment
RUN python manage.py migrate

# Expose port 8000 for the app
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
