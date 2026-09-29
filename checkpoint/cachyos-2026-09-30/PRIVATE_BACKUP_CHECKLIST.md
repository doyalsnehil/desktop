# Private backup checklist (outside public Git)

Use private encrypted storage if you want to retain any of these before wiping. This checkpoint contains none of their contents.

- SSH private keys and agent material (`~/.ssh/`), GPG private keys (`~/.gnupg/`), certificates and signing keys.
- Password manager databases, recovery codes and 2FA backup files, keyrings and wallets.
- Browser bookmarks, profiles, saved passwords, extensions and tabs if desired; app login state and application secrets.
- Personal documents, photos and videos, including the selected wallpaper `~/Downloads/onePiece.png` if you want the same image.
- Repositories with unpushed commits or untracked work, including other projects and the separate Neovim repository. Verify their remote state independently.
- Game saves, application data, music libraries, and any project datasets you value.
- GitHub/Code/agent credentials and access tokens only via their own secure re-authentication or private backup procedure. Never paste them into this repository.
- Root-only custom sudoers rules, if present in `/etc/sudoers.d/`; inspect privately. Keep permission modes and review policy before restoring.
- NetworkManager connections and Wi-Fi credentials if you need them; recreate locally rather than adding their profiles to this public checkpoint.

This list is a reminder, not proof that any private data has been backed up. Confirm the external backup and its readability yourself before wiping.
