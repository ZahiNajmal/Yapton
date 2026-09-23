# Yapton

**Yapton is a small educational programming language that lets learners write Python-style programs with a few slang-inspired keywords.** A Yapton file (`.yap`) is translated to Python in memory and then run with the normal Python runtime. It is intended as a friendly bridge to Python, not as a replacement for it.

## What this project does

Yapton keeps ordinary Python syntax, data types, loops, expressions, and standard-library imports. It adds the following alternative words:

| Yapton | Python meaning |
| --- | --- |
| `yap(...)` | `print(...)` |
| `spill(...)` | `input(...)`, converting number-looking input to `int` or `float` |
| `vibe name():` | `def name():` |
| `fanumtax math` | `import math` |
| `optionC` | `elif` |
| `otherwise` | `else` |
| `W` / `L` | `True` / `False` |

For example:

```yap
fanumtax math

vibe greet(name):
    yap("Welcome,", name)

name = spill("What is your name? ")
greet(name)
```

## Project roles

The codebase has three clear responsibilities:

| Part | Role |
| --- | --- |
| `src/yapton/__init__.py` | The **Yapton language engine**. It translates Yapton keywords into Python tokens, provides `spill`, runs `.yap` files, and prints the slang reference. |
| `src/yapton/cli.py` | The **command-line interface**. It accepts `yap program.yap` and `yap --slang-help`, then calls the language engine. |
| `pyproject.toml` | The **package configuration**. It declares the Python requirement and installs the `yap` command. |
| `sample1.yap` to `sample7.yap` | **Example Yapton programs**, ordered from small language demonstrations to larger projects. |
| `yap.bat` | The **Windows launcher**. It runs `python -m yapton.cli`, so it never depends on a copied, moved, or stale virtual environment. |

## Requirements

- Python 3.10 or newer
- PowerShell, Command Prompt, or another terminal
- Git, only if you want to publish the project on GitHub

Check that Python is available:

```powershell
py --version
```

If `py` is not found, install Python from [python.org](https://www.python.org/downloads/) and make sure the installer option to add Python to PATH is enabled.

## Run it locally (Windows / PowerShell)

Open PowerShell in this project folder, then create a fresh virtual environment and install Yapton in editable mode:

```powershell
cd "C:\path\to\Yapton"
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -e .
```

Run an example:

```powershell
yap sample2.yap
```

Or run the larger example:

```powershell
yap sample5.yap
```

See the built-in language reference at any time:

```powershell
yap --slang-help
```

### If PowerShell blocks activation

Activation is optional. Use the environment's Python directly instead:

```powershell
.\.venv\Scripts\python.exe -m pip install -e .
.\.venv\Scripts\yap.exe sample2.yap
```

### Run a new program

1. Create a file ending in `.yap`, such as `hello.yap`.
2. Add Yapton/Python code.
3. Run `yap hello.yap` while the environment is active.

Indentation and colons work exactly like Python. Regular Python can be mixed with the Yapton keywords shown above.

### Sample guide

| File | Demonstrates |
| --- | --- |
| `sample1.yap` | Functions, loops, lists, conditions, and Yapton booleans. |
| `sample2.yap` | Adding two numbers entered by the user. |
| `sample3.yap` | Subtracting two numbers entered by the user. |
| `sample4.yap` | Checking whether a number is positive or negative. |
| `sample5.yap` | A menu-driven student score tracker using Yapton imports. |
| `sample6.yap` | The same student tracker, showing that regular Python `import` also works. |
| `sample7.yap` | A first-person 3D maze. Install its extra dependency first with `python -m pip install ursina`. |

### Why `yap` works reliably in this folder

Windows chooses `yap.bat` in the current folder before an installed `yap` command. This project launcher deliberately uses `python -m yapton.cli` instead of a hard-coded path to `venv\\Scripts\\python.exe`. That means it uses the same Python installation that installed Yapton and will not break merely because a virtual-environment folder was moved, deleted, or created on another computer.

## Put it on GitHub

1. Sign in to [GitHub](https://github.com/) and select **New repository**.
2. Name it `Yapton`, choose Public or Private, and **do not** initialize it with a README, `.gitignore`, or license—the project already has the first two.
3. In PowerShell, from this project folder, run the following. Replace `YOUR-USERNAME` with your GitHub username:

```powershell
cd "C:\path\to\Yapton"
git init
git add .
git commit -m "Initial commit: Yapton language"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/Yapton.git
git push -u origin main
```

GitHub may ask you to sign in or create a personal access token when you push over HTTPS. If Git reports that a remote called `origin` already exists, update it instead:

```powershell
git remote set-url origin https://github.com/YOUR-USERNAME/Yapton.git
git push -u origin main
```

The included `.gitignore` prevents virtual environments, cache files, and build outputs from being uploaded. Do not upload `.venv/` or `venv/`; each contributor should create their own using the local setup steps above.

### Privacy check before publishing

The publishable source files contain no personal names, email addresses, passwords, API keys, or local computer paths. The ignored `venv/` folder is machine-specific and must not be uploaded. The `.gitignore` also excludes virtual environments and `.env` files, which are common places for private settings. Before each push, review exactly what will be uploaded with:

```powershell
git status
```

## Contributing

When adding a slang keyword, update both `NAME_MAP` and `print_slang_help()` in `src/yapton/__init__.py`, then add or update a `.yap` example that demonstrates it. Before committing, run an example and `yap --slang-help` to confirm the command still works.

## Current status

Yapton is an early educational prototype. Because programs ultimately execute as Python, only run `.yap` files you trust.
