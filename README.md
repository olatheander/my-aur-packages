# My AUR Packages

This repository contains my personal collection of custom AUR (Arch User Repository) packages and PKGBUILDs.

## Packages Included

- **[bindfs](./bindfs/)**: A FUSE filesystem for mirroring a directory to another directory, similar to 'mount --bind', with permission settings.
- **[ghcup-hs-bin](./ghcup-hs-bin/)**: Binary installer for the general-purpose Haskell installer (`ghcup`).
- **[slack-desktop-wayland](./slack-desktop-wayland/)**: Slack Desktop (Beta) for Linux with Wayland Support

## Installation Instructions

To install a package from a `PKGBUILD` file in this repository, follow these steps:

### Prerequisites

Ensure you have the `base-devel` package group installed, as it contains necessary tools like `make`, `gcc`, and `patch`:

```bash
sudo pacman -S --needed base-devel
```

### Steps to Install

1.  **Navigate to the package directory**:

    ```bash
    cd <package-directory>
    ```

    For example, to install `ghcup-hs-bin`:

    ```bash
    cd ghcup-hs-bin
    ```

2.  **Build and install the package**:
    Run `makepkg` with the `-s` (sync dependencies) and `-i` (install package) flags:

    ```bash
    makepkg -si
    ```

    - `-s`/`--syncdeps`: Automatically resolves and installs any missing dependencies via pacman.
    - `-i`/`--install`: Installs the package once built successfully.

### Additional `makepkg` Flags

- **Clean build directory**: Use `-c` or `--clean` to remove temporary work files after a successful build:
  ```bash
  makepkg -sic
  ```
- **Build only (no install)**: If you only want to compile and generate the package file without installing it, omit `-i`:
  ```bash
  makepkg -s
  ```
  This will generate a `.pkg.tar.zst` file, which you can install later using:
  ```bash
  sudo pacman -U <package-name>.pkg.tar.zst
  ```

## Updating Packages

### Updating a Single Package Manually

If you want to fetch an updated `PKGBUILD` from the AUR using `yay` and rebuild/reinstall the package:

1.  **Fetch the latest `PKGBUILD`**:

    ```bash
    yay --getpkgbuild <package-name>
    ```

    _(Note: `yay -G <package-name>` is the shorthand equivalent for this command.)_

2.  **Navigate into the directory**:

    ```bash
    cd <package-name>
    ```

3.  **Rebuild and upgrade the package**:
    ```bash
    makepkg -si
    ```
    This will build the new version and upgrade your existing installation.

### Automating Updates for All Packages

We have included a helper script `update-packages.sh` to fetch updates for all packages tracked in this repository using their folder names:

Run the script from the root of the repository:

```bash
./update-packages.sh
```

## Uninstallation

Since packages built via `makepkg` are registered with the local `pacman` database, they can be cleanly uninstalled using standard package management commands:

- **Standard removal**:

  ```bash
  sudo pacman -R <package-name>
  ```

- **Remove package along with its unused dependencies**:
  ```bash
  sudo pacman -Rs <package-name>
  ```
