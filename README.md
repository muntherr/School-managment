# School Management System

This project is a school management system with a server-side component and a mobile application front-end.

## Prerequisites

Before you begin, ensure you have met the following requirements:
- You have a Windows/Mac/Linux machine.
- You have installed the latest version of [Python](https://www.python.org/downloads/).
- You have installed [Visual Studio Code (VS Code)](https://code.visualstudio.com/).
- You have installed [Android Studio](https://developer.android.com/studio).
- You have installed [Flutter](https://flutter.dev/docs/get-started/install) and the Dart plugin for Android Studio.

## Installation

Follow these steps to set up your development environment:

### Visual Studio Code Setup
1. Download and install Visual Studio Code from [here](https://code.visualstudio.com/).
2. Open VS Code and install extensions for Python and any other languages or frameworks you will be using.

### Android Studio and Flutter Setup
1. Download and install Android Studio from [here](https://developer.android.com/studio).
2. During installation, ensure that the Flutter and Dart plugins are selected.
3. Once installed, open Android Studio and navigate to `Plugins` from the IDE settings.
4. Search for the Flutter plugin and install it (this should automatically install the Dart plugin).

### Python Installation
1. Download and install Python from [here](https://www.python.org/downloads/).
2. Ensure that Python is added to your system's PATH.
3. Verify the installation by opening a terminal and typing `python --version`.

## Running the Application

### Setting Up the Server

1. Open a terminal or command prompt.
2. Navigate to the directory where your server-side Python code is located.
3. Install the required Python packages by running: `pip install -r requirements.txt`
This command assumes you have a `requirements.txt` file listing all the necessary Python packages.

### Running the Server

1. In the same directory, start the server by executing: `python main.py`
This command runs the `main.py` file, which should be the entry point of your server application.

### Configuring the Front-End

1. After starting the server, copy the IP address it is running on.
2. Open Android Studio and navigate to the front-end folder.
3. Go to `lib/api-handling/connectionSetup.dart`.
4. Paste the copied URL in the `string url = ''` section.

### Starting the Front-End Application

1. In Android Studio, select Chrome (web) as the target device.
2. Run the program to start the front-end application.



# Diagrams
## User flow Diagram
![User flow](diagrams/User%20flow.drawio.png)
## DataBase Schecma
![DataBase Schema](diagrams/DataBase%20schema.drawio.png)



