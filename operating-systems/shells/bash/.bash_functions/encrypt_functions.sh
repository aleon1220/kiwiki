
function secCheckGpg{
    gpg --card-status
    gpg --list-secret-keys --keyid-format=long
    gpg --expert --list-keys
}

function secGitSignGpg{
    git commit --gpg-sign=4C12A6C4A0254B44 --signoff
    git push
}