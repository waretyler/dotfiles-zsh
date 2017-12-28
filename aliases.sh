alias -g .so=". ~/.zshrc"
alias g="git"

if [ "$OS" = "darwin" ]; then
  alias osReference="grep '^ *kVK' /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h|tr -d ,|while read x y z;do printf '%d %s %s\n' $z $z ${x#kVK_};done|sort -n"
  alias os.o='application=$(ls -1 /Applications | sed "s/.app//" | fzf) && open -a ${application}.app'
  alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
  alias c="pbcopy"
  alias v="pbpaste"
elif [ "$OS" = "linux" ]; then
  alias c="xclip -selection clipboard"
  alias v="c -o"
fi

alias f="fzf --query"
alias path.f='echo $path | tr " " "\n" | fzf -m --preview "ls {}"'

alias g.fzf="g ls-files | fzf"

# LaTex
alias watchtex="latexmk -gg -bibtex-cond -pdf -pvc"
alias cleantex="rm *.{aux,fdb_latexmk,fls,log,pdf}"
alias lt="tree -LC 2"
alias less="less -r"

alias patch.paste="(v; echo -e '\n') | patch -p0"

alias lf="ls_fzf"
alias ls.d="(find . -type d | sed 's/\/$//')"
alias ls.idea='(ls_dir_match ".idea" "node_modules")'
alias ls.git='(ls_dir_match ".git" "node_modules")'

alias cdp='project_dir=$(psel) && cd $project_dir' 

alias -g e="nvim"
alias -g ef='edit_files=$(fzf -m) && (echo $edit_files | xargs e)'
alias -g e.="(cd $cfg/dotfiles && ef)"
alias -g e.sh="(cd $cfg/zsh && ef && .so)"
alias -g e.vim="(cd $cfg/vim && ef)"
alias -g e.emacs="(cd $cfg/emacs && ef)"
alias -g e.snippets="(cd $cfg/snippets && ef)"
alias -g e.p='cdp && ef'

alias rmf="(fzf -m --preview='ccat {}' || exit 0) | xargs rm -rf"

alias g.root="cd \$(git rev-parse --show-toplevel)"
alias g.clean="(git ls-files -md | xargs git reset HEAD) && (git ls-files -md | xargs git checkout --) && (git ls-files -o --exclude-standard | xargs rm -rf)"
alias g.ppull='(psel | while read -r dir; do; cd $dir && git pull; done)'
alias g.co='branch_to_checkout=$(git branch | fzf | cut -c 3-) && git checkout $branch_to_checkout'

alias gh.select_repo='github_repo=$(select_github_repositories)'
alias gh.clone='(gh.select_repo && cd $p && git clone "https://github.com/${github_repo}")'
alias gh.view='(gh.select_repo && xdg-open "https://github.com/${github_repo}")'

#alias s?="search"
alias www='($FIREFOX_PROFILE && sqlite3 "$FIREFOX_PROFILE/places.sqlite" "select host from moz_hosts order by frecency desc;" | fzf | sed "s;^;https://;" | xargs xdg-open)'


# Local configuration
if [ -f $PZSH/aliases.local.sh ]; then
  source $PZSH/aliases.local.sh
fi

if [[ "$(echo $SHELL | grep -oh '[^/]*$')" = "zsh" ]]; then
  alias bindkey.ls="bindkey | fzf > /dev/null"
fi

alias lcat="ls | fzf -m --preview='cat {}'"
alias g.gpull="(psel | while read -r dir; do; cd \$dir && git add . && git commit && git pull && git push; done)"
alias g.bclean='git branch -D $(git branch | fzf -m)'
alias g.spop='stash=$(git stash list | fzf --preview "git diff \$(echo {} | egrep -oh \"^[^:]*\")" | egrep -oh "^[^:]+") && git stash pop "$stash"'
alias -g jq.cli="jq -cR '[splits(\" +\")]' | jq -s '.'"
alias open="xdg-open"

alias build.fr="(cd $ts_code/tsheets_app/trunk/.frontend && npm run build:all-for-distribution)"
