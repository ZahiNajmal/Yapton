import sys

from . import print_slang_help, run_file


def main(argv: list[str] | None = None) -> None:
    if argv is None:
        argv = sys.argv[1:]

    # Usage:
    #   yap program.yap
    #   yap --slang-help
    if len(argv) == 1 and argv[0] == "--slang-help":
        print_slang_help()
        raise SystemExit(0)

    if len(argv) != 1:
        print("Usage: yap <program.yap> | --slang-help")
        raise SystemExit(1)

    run_file(argv[0])


if __name__ == "__main__":  # pragma: no cover
    main()
