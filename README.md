# subsurf

A Subway Surfers demake. [pre-alpha]

> [!WARNING]
> Windows users: please use WSL! Due to a bug in Make, this project will **not** work outside of WSL!

## Downloading

Downloading this repository requires some extra care, due to it using submodules.
(If you know how to handle them, nothing more is needed.)

### Cloning

If cloning this repo from scratch, make sure to pass the `--recursive` flag to `git clone`; if you have already cloned it, you can use `git submodule update --init` within the cloned repo.

If the project fails to build, and either `src/include/hardware.inc/` or `src/include/rgbds-structs/` are empty, try running `git submodule update --init`.

### Download ZIP

You can download a ZIP of this project by clicking the "Code" button.
The resulting ZIP will however not contain the submodules, the files of which you will have to download manually.

## Setting up

Make sure you have [RGBDS](https://github.com/rednex/rgbds), at least version 0.6.0, and GNU Make installed, at least version 3.0.
Python 3 is required for most scripts in the `src/tools/` folder.

## Compiling

Simply open you favorite command prompt / terminal, place yourself in this directory (the one the Makefile is located in), and run the command `make`.
This should create a bunch of things, including the output in the `bin` directory.

> [!IMPORTANT]
> While this project is able to compile under "bare" Windows (i.e. without using MSYS2, Cygwin, etc.), it requires PowerShell.

Pass the `-s` flag to `make` if it spews too much input for your tastes.
Pass the `-j <N>` flag to `make` to build more things in parallel, replacing `<N>` with however many things you want to build in parallel; your number of (logical) CPU cores is often a good pick (so, `-j 12` for me). Run the command `nproc` to see how many cores you have.

If you get errors that you don't understand, try running `make clean`.
If that gives the same error, try deleting the `assets` directory.
If that still doesn't work, try deleting the `bin` and `obj` directories as well.
If that still doesn't work, feel free to ask for help.

## See also

Based on [gb-starter-kit](https://github.com/ISSOtm/gb-starter-kit)

I recommend the [BGB](https://bgb.bircd.org) emulator for developing ROMs on Windows and, via Wine, Linux and macOS (64-bit build available for Catalina).
[SameBoy](https://github.com/LIJI32/SameBoy) is more accurate, but has a more lackluster interface outside of macOS.

### Libraries

- [Structs in RGBDS](https://github.com/ISSOtm/rgbds-structs)
