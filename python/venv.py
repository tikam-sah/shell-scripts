import os
import subprocess
import sys

# Define the project directory and virtual environment
project_dir = 'projects'
venv_dir = os.path.join(project_dir, 'venv')
requirements = [
    'pandas',
    'selenium',
    'numpy',
    'mysql-connector-python',
    'urllib3'
]

def run_command(command, cwd=None):
    """Run a command with optional working directory."""
    result = subprocess.run(command, shell=True, cwd=cwd, text=True, capture_output=True)
    if result.returncode != 0:
        print(f"Error running command: {command}")
        print(result.stderr)
        sys.exit(result.returncode)
    return result.stdout

def main():
    # Create the project directory
    if not os.path.exists(project_dir):
        print(f"Creating project directory: {project_dir}")
        os.makedirs(project_dir)
    
    # Create the virtual environment
    print(f"Creating virtual environment in {venv_dir}")
    run_command(f"python3 -m venv {venv_dir}")

    # Install packages
    pip_path = os.path.join(venv_dir, 'bin', 'pip')
    print("Upgrading pip...")
    run_command(f"{pip_path} install --upgrade pip")
    
    print("Installing packages...")
    for package in requirements:
        run_command(f"{pip_path} install {package}")

    print("Setup complete. Virtual environment created and packages installed.")

if __name__ == "__main__":
    main()
