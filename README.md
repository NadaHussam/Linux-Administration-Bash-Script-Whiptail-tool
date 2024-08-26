# Linux-Administration-Bash-Script-Whiptail-tool
Bash Script containing 10 services for system administrating, using the whiptail tool for Gui interaction

### **User and Group Management Tool**

This Bash script collection provides a user-friendly graphical interface for managing users and groups on Unix-like systems. It utilizes the `whiptail` library to create interactive dialog boxes for various administrative tasks.

**Key Features:**
* **User Management:**
    - Create, modify, or delete users
    - Change user passwords
    - Manage user comments and group affiliations
* **Group Management:**
    - Create, modify, or delete groups
    - Manage group memberships
    - Modify group IDs (GIDs)

**Prerequisites:**
* **whiptail:** This script requires the `whiptail` package to be installed on your system. You can typically install it using your package manager:
  * **Fedora/CentOS/RHEL:**
    ```bash
    sudo dnf install whiptail
    ```

**How to Use:**
1. **Clone the repository:** 
   ```bash
   git clone https://github.com/NadaHussam/Linux-Administration-Bash-Script-Whiptail-tool.git
   ```
2. **Make the scripts executable:**
   ```bash
   chmod +x *.sh
   ```
3. **Run the main script:**
   ```bash
   ./main.sh
   ```

**About whiptail:**

`whiptail` is a command-line utility that provides a variety of dialog boxes for interactive input and output. It's used in this script to create menus, input fields, and other user-friendly elements.

**Note:** Ensure that you have the necessary permissions to perform administrative tasks on your system.

