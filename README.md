# IO-PRC-ATOW - Template for Application Repositories

This repository is a sample repository for developing Python related IO-Swiss Aero GmbH applications.

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-prc-atow/). 
See that documentation for installation instructions

Further IO-Swiss Aero GmbH software documentation can be found under the following links.

- TBD
<!-- - [IO-PRC-ATOW - Template for Application Repositories](https://io-swiss.github.io/io-prc-atow/) -->

## Directory and File Structure of this Repository

### 1. Directories

| Directory         | Content                                              |
|-------------------|------------------------------------------------------|
| .github/workflows | GitHub Action workflows.                             |
| .vscode           | Visual Studio Code configuration files.              |
| data              | Application data related files.                      |
| dist              | Dynamic link library version of **IO-PRC-ATOW**. |
| docs              | Documentation files.                                 |
| examples          | Scripts for examples and special tests.              |
| ioprcatow         | Python script files.                                 |
| libs              | Contains libraries that are not used via pip.        |
| resources         | Selected manuals and software.                       |
| scripts           | Scripts supporting macOS, Ubuntu and Windows.        |
| tests             | Scripts and data for examples and tests.             |

### 2. Files

| File                            | Functionality                                                         |
|---------------------------------|-----------------------------------------------------------------------|
| .act_secrets_template           | Template file for the configuration of ``make action``.               |
| .dockerignore                   | Configuration of files and folders to be ignored.                     |
| .gitattributes                  | Handling of the os-specific file properties.                          |
| .gitignore                      | Configuration of files and folders to be ignored.                     |
| .pylintrc                       | pylint configuration file.                                            |
| .settings.io_aero_template.toml | Template file for the secret configuration data.                      |
| Dockerfile                      | Configuration file to create a Docker image.                          |
| environment.yaml                | Definition of the Python package requirements - productive version.   |
| environment_dev.yaml            | Definition of the Python package requirements - development version.  |
| LICENSE.md                      | Text of the licence terms.                                            |
| logging_cfg.yaml                | Configuration of the Logger functionality.                            |
| Makefile                        | Tasks to be executed with the make command.                           |
| pyproject.toml                  | Optional configuration data for the software quality tools.           |
| README.md                       | This file.                                                            |
| run_io_prc_atow                 | Main script for using the functionality based on a Nuitka executable. |
| run_io_prc_atow_dev             | Main script for using the functionality in a development environment. |
| run_io_prc_atow_prod            | Main script for using the functionality in a productive environment.  |
| run_io_prc_atow_pytest          | Main script for using the functionality in a test environment.        |
| run_ioprcatow                   | Main script for using the functionality based on a Docker executable. |
| settings.io_aero.toml           | Configuration data.                                                   |
| setup.cfg                       | Configuration data.                                                   |

## Converting the application into an executable file

### 1. Common Characteristics

This section details the shared characteristics of both `docker2exe` and `Nuitka` when used to convert the `io-prc-atow` into an executable file. These features are crucial for understanding the overall approach and platform-specific considerations necessary for the conversion process.

- **Target Platforms**:
The tools support creating executables specifically for macOS, Ubuntu, or Windows. This allows for precise targeting based on deployment needs.

- **Platform-Specific Build**:
The process of creating an executable is required to be conducted on the operating system for which the executable is intended. This means building a Windows executable on a Windows machine, a macOS executable on a macOS machine, and so on.

- **Use of Makefile**:
Both `docker2exe` and `Nuitka` utilize the Makefile of `ioprcatow` to facilitate the construction of executables. 

### 2. Using docker2exe

**a. The prerequisites are:**

- Go Programming Language: `docker2exe` is developed in Go, so Go must be installed on the system to either compile from source or run the pre-compiled binaries.
- Docker: Docker is required as `docker2exe` converts Docker images into executable files.

The executable files for `docker2exe` are downloaded from the [GitHub Releases page](https://github.com/rzane/docker2exe). Note that the executable for Windows has been renamed to `docker2exe-windows-amd64.exe` and is located in the `dist` directory of the application. Visit the [docker2exe tool page](https://github.com/rzane/docker2exe) for more details and to access the source code.

**b. Creating the Executable File**

- Run `make docker`

- The Docker image named `ioprcatow` is first created.
 
- `docker2exe` is then used to convert the Docker image into an executable file.

- A directory is finally created containing all the files necessary for running the application. The name of this directory varies depending on the operating system and architecture:
    - **macOS**: `app-darwin-amd64` or `app-darwin-arm64`
    - **Ubuntu**: `app-linux-amd64`
    - **Windows**: `app-windows-amd64`

- The directory, in addition to the executable file (`ioprcatow` or `ioprcatow.exe`), includes the following components:
    - **data**: A directory for the application data.
    - **logging_cfg.yaml**: A configuration file for logging.
    - **run_io_prcatow.[bat|sh|zsh]**: A shell script to run the application.
    - **settings.io-aero.toml**: Configuration data for the `ioprcatow`.

- The converted application requires Docker to be installed in order to run, ensuring that the application's environment is appropriately replicated.

### 3. Using Nuitka

Nuitka is a Python compiler that translates Python code into C++ and then compiles it into an executable file. This section explains the steps involved in using Nuitka to convert the `io-prc-atow` into a standalone executable file.

**a. The prerequisites are:**

- **C++ Compiler**: Nuitka requires a C++ compiler as it converts Python code into C++. For macOS and Ubuntu, the system's native C++ compiler is sufficient. Windows users must install the Community version of Visual Studio 2022 to obtain the necessary C++ build tools.
  - Detailed installation instructions for Visual Studio 2022 are available on the [Visual Studio Release page](https://visualstudio.microsoft.com/vs/).
  - It is crucial to follow the installation instructions provided on the release page of `io-prc-atow` to ensure all required components are installed.


**b. Creating the Executable File**

1. **Creating the Executable**:
   - To create the executable file for the `ioprcatow`, the command `make nuitka` is utilized. This command invokes Nuitka to compile the Python script into an executable.

2. **Output Directory**:
   - The executable file is placed in the `dist` directory within the project structure once compilation is complete.

**c. Running the Application**

- **Execution Script**: To execute the application, use the provided shell script named `run_io_prc_atow_prod.[bat|sh|zsh]`, which simplifies the launch process. This script is tailored to ensure that the application executes in a production environment, utilizing the newly compiled executable.
