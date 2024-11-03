function enable_keepass_ssh_agent
    eval (ssh-agent -c)
    keepassxc &
end
