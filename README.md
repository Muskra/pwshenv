# What the script does

It creates the following directories:

* ~/.tools/
* ~/.tools/bin/
* ~/.tools/src/

Appends content to the powershell current user's profile (generally `~\Documents\WindowsPowerShell\profile.ps1`) that adds automatically every element of `~/.tools/bin/` as aliases for the current user.

# Preparation before usage

Clone the repository with: `git clone https://github.com/Muskra/pwshenv.git`
Then, move to the directory created: `cd pwshenv/`
Afterwards, create two directories: `mkdir bin ; mkdir src`

You can now place your binaries into the `bin/` directory, and use the `src/` directory to place your sources if needed.
Those will be moved to the new environment at installation. 

# Limitations

You can't symlink/hardlink or use shortcuts before deployment, those should be created afterwards.

# Usage

Launch the `install.ps1` when everything is setup to be deployed.
