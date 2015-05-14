Rails.application.routes.draw do
  # Load angular app from this route.
  root 'home#index'

  # Angular routing will be handling any routes that aren't scoped to "/api/some/route"
  get '*unmatched_route', :to => 'home#index'
end
