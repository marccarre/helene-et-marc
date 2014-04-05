#!/bin/bash
if ! [[ $(git remote) =~ "heroku" ]]; then

	project="helene-et-marc"
	git remote add heroku git@heroku.com:$project.git
	heroku git:remote -a $project
	echo "[success] Configured project for deployment to Heroku."

	if ! [[ -f .env ]]; then
		touch .env
	fi
	echo "[warning] Please configure .env with the required variable among:"
	heroku config

	echo # newline
	return 0
fi

source .env
rake db:drop && rake db:create:all && rake db:migrate && rake db:seed
bundle exec sidekiq
