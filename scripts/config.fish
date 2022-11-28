function createpp
    mkdir -p ~/Projects/$argv
    cd ~/Projects/$argv
    mkdir venv
    touch main.py
    python3 -m venv ~/Projects/$argv/venv
    git init
    git add .
    git commit -m "Initialize project."
    clear
    openpp $argv
end

function openpp
    cd ~/Projects/$argv
    code .
    source venv/bin/activate.fish
end

function closepp
    deactivate
    cd
end


alias update="yay --noconfirm -Syu"
