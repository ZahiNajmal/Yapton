@echo off
REM Run Yapton with the same Python installation used for `python -m pip install -e .`.
REM Do not point at a project-local virtual environment: it may have been moved or deleted.
where python >nul 2>&1
if not errorlevel 1 (
    python -m yapton.cli %*
    exit /b %errorlevel%
)

where py >nul 2>&1
if not errorlevel 1 (
    py -m yapton.cli %*
    exit /b %errorlevel%
)

echo Python was not found. Install Python 3.10+ and run: python -m pip install -e .
exit /b 1
