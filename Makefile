# NO idea if this works on Windows...
# If oyu ran the botstrapper it would as it installed Makefile for windows and seems to work.

UPSTREAM_ORG=getcouragenow
FORK_ORG=$(shell basename $(dir $(abspath $(dir $$PWD))))
REPO_NAME=$(notdir $(shell pwd))

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print:
	@echo

	@echo FORK_ORG: $(FORK_ORG)
	@echo UPSTREAM_ORG: $(UPSTREAM_ORG)
	@echo REPO_NAME: $(REPO_NAME)
	@echo


#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork

git-fork-open: ## git-fork-open
	open https://github.com/$(FORK_ORG)/$(REPO_NAME).git

git-fork-setup: ## git-fork-setup
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git

git-fork-catchup: ## git-fork-catchup
	# This fetches the branches and their respective commits from the upstream repository.
	git fetch upstream 

	# This brings your fork's master branch into sync with the upstream repository, without losing your local changes.
	git merge upstream/master

	# then in VSCODE just sync to push upwards to your fork.

 