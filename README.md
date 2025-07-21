# foundryup on Windows

Complete guide for installing and configuring `foundryup` on Windows with all prerequisites.

## Prerequisites

### 1. Install Rust

Foundry requires Rust to be installed on your system.

1. Download the Rust installer from [https://rustup.rs/](https://rustup.rs/)
2. Run `rustup-init.exe`
3. Follow the installation prompts (default options are usually fine)
4. After installation, restart your terminal or command prompt

To verify Rust installation:
```bash
rustc --version
cargo --version
```

### 2. Configure Rust Paths

Rust installer typically adds the following paths automatically, but verify they exist in your PATH:
- `%USERPROFILE%\.cargo\bin` (for Cargo and Rust tools)

To manually add to PATH if needed:
1. Press `Win + X` and select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "User variables", select "Path" and click "Edit"
5. Add `%USERPROFILE%\.cargo\bin` if not present
6. Click "OK" to save changes

### 3. Install Visual Studio 2022 Build Tools

Rust on Windows requires C++ build tools for linking.

1. Download Visual Studio 2022 Build Tools from [https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
2. Run the installer
3. In the installer, select:
   - **Workloads tab**: Check "Desktop development with C++"
   - This will include:
     - MSVC v143 - VS 2022 C++ x64/x86 build tools
     - Windows 11 SDK (or Windows 10 SDK)
     - C++ CMake tools for Windows (required)
4. Click "Install" and wait for completion
5. Restart your computer after installation

### 4. Configure CMake Path

CMake is installed with Visual Studio Build Tools but may not be automatically added to PATH.

1. Verify CMake installation by checking if this path exists:
   ```
   C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
   ```

2. Add CMake to your PATH:
   - Press `Win + X` and select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "System variables" (or "User variables"), select "Path" and click "Edit"
   - Click "New" and add:
     ```
     C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
     ```
   - Click "OK" to save changes

3. Verify CMake is accessible:
   - Open a new terminal (important: must be new to load updated PATH)
   - Run:
     ```bash
     cmake --version
     ```
   - You should see the CMake version information

## Installing foundryup

After completing all prerequisites:

1. Create a folder for foundryup (e.g., `C:\foundry`)
2. Add the folder to your PATH:
   - Press `Win + X` and select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "User variables", select "Path" and click "Edit"
   - Click "New" and add your folder path (e.g., `C:\foundry`)
   - Click "OK" to save
3. Copy `foundryup.bat` into the folder you created
4. Open a new terminal and run:
   ```bash
   foundryup
   ```

## Verifying Installation

After running `foundryup`, verify the installation:
```bash
forge --version
cast --version
anvil --version
chisel --version
```

## Troubleshooting

- **"cargo not found"**: Ensure Rust is installed and `%USERPROFILE%\.cargo\bin` is in your PATH
- **"cmake not found"**: Ensure CMake path is added to your PATH (see step 4 above)
- **Linking errors**: Verify Visual Studio Build Tools are installed with C++ components
- **"foundryup not recognized"**: Ensure your foundryup folder is in PATH and you've restarted your terminal

## Dependencies Summary

- **Rust**: Latest stable version via rustup
- **Visual Studio 2022 Build Tools**: With C++ desktop development workload
- **CMake**: Included with VS Build Tools (must be added to PATH manually)
- **Git**: For downloading dependencies (usually pre-installed on Windows 10/11)

Enjoy using Foundry!
