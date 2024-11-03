if test -d $HOME/projects
   set -gx project_dir_1 $HOME/projects
end

if test -d $HOME/projects/personal
   set -gx project_dir_2 $HOME/projects/personal
end

if test -d $HOME/work/projects
   set -gx project_dir_3 $HOME/work/projects
end

function cdp
    cd $(find $project_dir_1 $project_dir_2 $project_dir_3 -maxdepth 1 | fzf)
end
