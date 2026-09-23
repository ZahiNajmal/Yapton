@echo off
echo Cleaning up for GitHub...
python github_cleanup.py
echo.
echo Final directory structure:
dir /b
echo.
echo Ready for GitHub!
