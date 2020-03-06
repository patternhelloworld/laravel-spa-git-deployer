{

  your_branch_name="develop"
  timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
  npm_local_cmd="dev"
  npm_real_cmd="real"

  # This should be safe as your local setting values are different from your remote server.
  # Remove all Laravel caches here
  php artisan cache:clear
  php artisan config:clear
  php artisan route:clear
  php artisan view:clear

  # [Front build for real-server] Based on your 'package.json' and webpack settings, this command can be changed.
  npm run ${npm_real_cmd}

} || {

    echo "Pushing failed in the first step.";
    exit;
}

{

  # 'node_modules' and 'vendor' folders should be added to the 'real' branch, however, not to your source management branch.
  cp .gitignore .original_gitignore
  cp .deploy_gitignore .gitignore

  # Reflect changed .gitignore
  git rm -r --cached .
  git add .
  # This commit is to prevent the loss of your work.
  git commit -m "Distributed to REAL at ${timestamp}"

  # Initialize the real branch preparing for possible collisons.
  git branch -D real
  git push origin --delete real

  git branch real
  git checkout real

  # Can run the puller.sh after this process has completed.
  git push -u -f origin real


} || {

    cp .original_gitignore .gitignore
    git checkout ${your_branch_name}

    echo "Pushing failed in the second step.";
    exit;
}

{
  # From now, we normalize the local environment back.
  git checkout ${your_branch_name}

  # .gitignore should be recovered
  cp .original_gitignore .gitignore
  git rm -r --cached .

  git add .
  # [Front build for local-server] Based on your 'package.json' and webpack settings, this command can be changed.
  npm run {$npm_local_cmd}

  # The commit will be hidden on this branch log.
  git reset --soft HEAD~1

}|| {

    cp .original_gitignore .gitignore

    echo "Pushing success but some problems in local.";
    exit;
}