import os
import shutil

# Files and directories to remove for GitHub
items_to_remove = [
    "__pycache__",
    ".venv", 
    "dist",
    "src/yapton.egg-info",
    "src/yapton/__pycache__",
    ".vscode",
    "cleanup.py",
    "FILES_TO_KEEP.txt", 
    "MANUAL_CLEANUP.txt",
    "remove_venv.py",
    "cleanup_venv.bat"
]

print("Cleaning up for GitHub...")

for item in items_to_remove:
    if os.path.exists(item):
        try:
            if os.path.isdir(item):
                shutil.rmtree(item)
                print(f"✓ Removed directory: {item}")
            else:
                os.remove(item)
                print(f"✓ Removed file: {item}")
        except Exception as e:
            print(f"✗ Error removing {item}: {e}")
    else:
        print(f"- Not found: {item}")

print("GitHub cleanup complete!")
