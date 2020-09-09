new: ## Make new post with date as slug
	hugo new posts/$(shell date '+%Y-%m-%d')/index.md