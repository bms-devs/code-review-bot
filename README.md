## Code Review Bot

Script that automatically draws a developer for code review and posts the information to Slack.

Add this script to your CI (e.g. Jenkins) to be run at the end of the build following a new commit (e.g. triggerred by Gerrit).

#### Usage

1. Create `config.cfg` from `config.cfg-template`.
2. Fill in the required information:
    - Slack hook URL
    - Gerrit base URL
    - list of developers - in the form of a bash array, i.e. `DEVS=("john.connor" "mary.jane" "peter.parker")`
3. Configure the script to be run from CI
    - invoke with two arguments provided by the Jenkins Gerrit plugin, i.e. `/opt/code_review.sh $GERRIT_CHANGE_NUMBER $GERRIT_PATCHSET_UPLOADER`

#### Features
- Currently works for the Jenkins - Gerrit configuration only
- The script keeps track of commits, for which a reviewer had been drawn, so if a new patchset for the same commit is pushed, it will not draw again.

#### Todo

- The commit author is currently not filtered our - so one can be drawn to review their own commit. To be corrected. 