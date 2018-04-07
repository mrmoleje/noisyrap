# noisyrap
Analysis of noise complaints in NYC RAP Report

practice using RAP and Github

Typical GIT workflow

6.3 Typical workflow
When you first start using git it can be difficult to remember all the commonly used commands (you might find it useful to keep a list of them in a text editor).

We give a simple workflow here (assuming you are collaborating on Github with a small team and have set up a repo called my_repo with the origin and remote set (try to avoid hyphens in names)). Remember to remove the comments (the #) when copying and pasting into the terminal. You will also need to give your new feature branch a good name.

Open your terminal (command line tool).
Navigate to my_repo using cd.
Check you are up-to-date:
#  git checkout master
#  git pull
Create your new feature branch to work on and get to work (track changes by adding and comitting locally as usual):
#  git checkout -b feature/post_name
Squash your commits if appropriate, then push your new branch to Github. You will want to squash all commits together associated with one discrete piece of work (e.g. coding one function).
#  git push origin feature/post_name -u
On Github create a pull request and ask a colleague to review your changes before merging with the master branch (you can assign a reviewer in the PR page on Github).

If accepted (and it passes all necessary checks) you’re new feature will have been merged on Github. Fetch these changes locally.

#  git checkout master
#  git pull
You have a new master on Github. Pull it to your local machine and the development cycle starts again!
CAVEAT: this workflow is not appropriate for large open collaborations, where fork and pull is preferred.

6.4 Branch naming etiquette
Generally I will start a new branch to either add a new feature git branch feature/cool_new_feature such as for testing or adding a new function git branch feature/sen_function_name. Or if fixing a bug or problem. We should be writing these on the Github issues page for the package. We can then title our branches to tackle specific issues git branch fix/issue_number.
It’s good to push your branches to Github if your working on it prior to it being finished so we all know what everyone is working on. You can simply put [WIP] (Work in progress) in the title of the PR on Github to let people know its not ready for review yet.

6.5 Watermarking
Imagine if someone asks you to reproduce some historic analysis further down the line. This will be easy if you’ve used git as long as you know which version of your code was used to produce the report (packrat also facilitates this). You can then load that version of the code to repeat the analysis and reproduce the report.

As an additional measure, or if you find versioning intimidating, you could watermark your report by citing the git commit used to generate it, as demonstrated below and in the stackoverflow answer by Wander Nauta, 2015.

print(system("git rev-parse --short HEAD",
             intern = TRUE))
## [1] "da70797"
This commit hash can be used to “revert” back to the code at the time the report was produced, fool around and reproduce the original report. You also have the flexibility to do other things which are explored in this Stack Overflow answer. This feature of version control is what makes our analytical pipelines reproducible.
