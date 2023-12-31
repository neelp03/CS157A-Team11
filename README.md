# UniRide Project Setup

## Prerequisites

- **IntelliJ Ultimate Edition**: Auto Installs Maven and Open JDK 21
  - if not then import project to any IDE and download the following dependencies:
    - **JDK**: OpenJDK 21 or equivalent. [Download here](https://adoptopenjdk.net/).
    - **Maven (4.0.0)**: Ensure Maven is installed. If not, [install Maven](https://maven.apache.org/download.cgi).
- **MySQL**: Ensure you have MySQL server running and accessible.
- **IntelliJ IDEA Ultimate**: This project was developed with IntelliJ IDEA Ultimate. While it might work with other IDEs, we recommend using IntelliJ for a smoother experience.

## Getting Started

1. **Clone the Repository**
   git clone https://github.com/neelp03/UniRide.git
   cd UniRide

2. **Setting up the Database**

- Make sure MySQL is running.
- copy paste the scripts inside each file into workbench and execute
  OR
- Run this command (make sure path is correct):
  ```
  mysql -u cs157a -p < schema.sql
  mysql -u cs157a -p < data.sql
  ```

3. **Build and Run the Project**

Open the project in IntelliJ IDEA Ultimate:
- Navigate to `File -> Open` and select the `UniRide` project directory.
- Wait for IntelliJ to import the project and download the necessary dependencies.
- Build the project using the `Build -> Build Project` option.
- To run, right-click on the main class in the project explorer and select `Run`.
  - opens a services side view where the web app logs and other services can be seen
  - tomcat should be there and running

5. **Accessing the Application**

By default, the application will run on `http://localhost:8080/UniRide`. Open this URL in a web browser to access the application.
