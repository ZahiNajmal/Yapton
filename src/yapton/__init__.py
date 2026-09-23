import sys
import io
import tokenize

# Yapton -> Python keyword / literal mapping
# We only touch NAME tokens, so strings and comments stay the same.
NAME_MAP = {
    # control flow
    "optionC": "elif",       # optionC -> elif
    "otherwise": "else",     # otherwise -> else

    # booleans
    "W": "True",             # W -> True
    "L": "False",            # L -> False

    # functions / I/O
    "yap": "print",          # yap(...) -> print(...)
    # NOTE: spill is implemented as a real Python helper function below,
    # not just a rename, so it can auto-convert numbers.

    # function definition
    "vibe": "def",           # vibe foo(): -> def foo():

    # imports
    "fanumtax": "import",    # fanumtax math -> import math
}


def spill(prompt: str = "") -> object:
    """Yapton input function.

    Behaves like Python's input(), but tries to convert what the user typed
    into an int or float. If that fails, it returns the raw string.
    """

    raw = input(prompt)
    # Try int first
    try:
        return int(raw)
    except ValueError:
        pass

    # Then try float
    try:
        return float(raw)
    except ValueError:
        return raw


def transpile(source: str) -> str:
    """Turn Yapton source into real Python source.

    This uses the tokenize module so we only rewrite identifier tokens,
    not things inside strings or comments. That way Python's own
    features (types, lists, slicing, loops, etc.) just work.
    """

    out_tokens = []

    # tokenize.tokenize works on bytes; we wrap the string in a BytesIO
    byte_stream = io.BytesIO(source.encode("utf-8"))
    try:
        for tok in tokenize.tokenize(byte_stream.readline):
            tok_type = tok.type
            tok_string = tok.string

            # Replace only identifier / name tokens that are in our mapping
            if tok_type == tokenize.NAME and tok_string in NAME_MAP:
                tok_string = NAME_MAP[tok_string]
                tok = tokenize.TokenInfo(tok_type, tok_string, tok.start, tok.end, tok.line)

            out_tokens.append(tok)
    except tokenize.TokenError as exc:
        raise SyntaxError(f"Yapton could not be tokenized: {exc}")

    # untokenize back to Python code
    return tokenize.untokenize(out_tokens).decode("utf-8")


def run_file(path: str) -> None:
    with open(path, "r", encoding="utf-8") as f:
        source = f.read()

    python_code = transpile(source)

    # Execute the transpiled Python. We let Python handle all the real
    # work: numbers, strings, lists, slicing, loops, functions, imports, etc.
    # Expose spill() so Yapton code can call it directly.
    globals_dict = {"__name__": "__main__", "spill": spill}
    try:
        exec(python_code, globals_dict)
    except Exception as exc:  # noqa: BLE001
        # Wrap any Python error with your custom prefix.
        print(f"error 67: {exc.__class__.__name__}: {exc}")
        sys.exit(1)


def print_slang_help() -> None:
    print("Yapton slang dictionary:\n")
    print("  W         -> True (boolean)")
    print("  L         -> False (boolean)")
    print("  if        -> if (same as Python)")
    print("  optionC   -> elif")
    print("  otherwise -> else")
    print("  yap       -> print")
    print("  spill     -> input (auto-converts to number when possible)")
    print("  vibe      -> def (define a function)")
    print("  fanumtax  -> import (bring in Python modules)")
    print("  #         -> comment (same as Python)")
    print("  type(...) -> same as Python type() and casts")
    print("  lists, slicing, for/while loops -> same as Python syntax")
