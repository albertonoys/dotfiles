function gs
  set cwd (pwd)
  cd $__dotfiles_CODE_DIR
  git fetch origin master alpha beta stable 2>/tmp/fetchoutputbuffer
  if test $status -eq 1
      cat /tmp/fetchoutputbuffer
  else
      rm /tmp/fetchoutputbuffer
  end
  set stable_version (git show origin/stable:versioninfo)
  set beta_version (git show origin/beta:versioninfo)
  set alpha_version (git show origin/alpha:versioninfo)
  set master_version (git show origin/master:versioninfo)
  set branch_version (git show origin/$argv:versioninfo)

  if [ $branch_version = $master_version ]
     echo -e '\033[0;32m'$branch_version '\033[1;32m' " [MASTER]"'\033[0m'
  else if [ $branch_version = $alpha_version ]
     echo -e '\033[0;32m'$branch_version '\033[1;32m' " [ALPHA]"'\033[0m'
  else if [ $branch_version = $beta_version ]
     echo -e '\033[0;32m'$branch_version '\033[1;32m' " [BETA]"'\033[0m'
  else if [ $branch_version = $stable_version ]
     echo -e '\033[0;32m'$branch_version '\033[1;32m' " [STABLE]"'\033[0m'
  else
     echo -e '\033[0;32m'$branch_version '\033[1;32m' " [OLD STABLE]"
     echo -e '\033[0;32m'$stable_version '\033[1;32m' " [CURRENT STABLE]"'\033[0m'
  end

  cd $cwd
end
