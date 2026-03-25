# VS Code setup

## roles include
- DevOps Engineer
- SRE
- Platform engineer
- 

This sets up VScode for a DevOps engineer
- docker and kubernetes plugins

- YAML and JSON plugins
- Git plugins
- Remote terminal and editor

#### check installed extensions
```bash
code --list-extensions
```
#### check installed extensions
```bash
EXTENSION_ID="vscjava.vscode-gradle"
code --install-extension $EXTENSION_ID
```

#### install exensions to a Profile
```powershell
code --profile Python --install-extension ms-python.python
```
#### uninstall exensions from a Profile
```powershell
code --profile "Java General" --uninstall-extension wakatime.vscode-wakatime
```
## References
- [Linux large files Workspace](https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc)
