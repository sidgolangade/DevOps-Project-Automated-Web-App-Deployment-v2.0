# Use an official Python runtime as a parent image
FROM python:3.11

# Set environment variables for Django
ENV DJANGO_SETTINGS_MODULE=FoodProject.settings

# Create and set the working directory
WORKDIR /app

# Copy the code updates into the container
COPY . /app/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Expose the port the application runs on
EXPOSE 8000

# Define the command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
