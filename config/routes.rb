Rails.application.routes.draw do
  # Sitemap
  # get '/sitemap.xml.gz', to: redirect('https://s3-eu-west-1.amazonaws.com/thegrowthbakeryblog/sitemap.xml.gz')
  # ------------------ Static Pages -----------------------
  # Private
  get '/admin' => 'pages#admin'
  # Public
  root 'pages#home'
  get '/blog' => 'pages#blog'
  get '/newsletter' => 'pages#newsletter'
  get '/videos' => 'pages#videos'
  get '/thanks' => 'pages#thanks'
  get '/thanks-30-min-call' => 'pages#thanks_call'
  get '/search' => 'pages#search'
  get '/contact' => 'pages#contact'
  get '/experiments' => 'pages#experiments', as: 'experiments'
  post '/experiments/send' => 'pages#experiments_send', as: 'experiments_send'
  get '/instant-message' => 'facebook_links#instant_message', as: 'instant_message'
  post '/send-instant-message' => 'facebook_links#send_instant_message', as: 'send_instant_message'
  post '/calendar/add-token', to: 'calendar#add_token', as: 'add_token'
  post '/request_access' => 'pages#request_access'

  # Redirect the errors
  %w[ 404 422 500 503 ].each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end
  # ------------------ Model Routing -----------------------
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_up: 'register' }
  resources :pages, :categories, :topics, :articles, :resources, :facebook_links
  resources :contactforms, only: %i[new create]

  get 'search/:id' => 'pages#search', as: 'resource_category'

  # This routes articles and resources. First it searches for a matching article by slug (friendly id), then
  # falls down to resources. Ex;
  # www.mysite.com/this-is-the-title-of-the-article  (articles#show)
  # www.mysite.com/cool-new-resource (resources#show)
  class ArticleUrlConstrainer
    def matches?(request)
      id = request.path[1..-1]
      Article.find_by_slug(id)
    end
  end

  constraints(ArticleUrlConstrainer.new) do
    match '/:id', via: [:get], to: 'articles#show'
  end

  class ResourceUrlConstrainer
    def matches?(request)
      id = request.path[1..-1]
      Resource.find_by_slug(id)
    end
  end

  constraints(ResourceUrlConstrainer.new) do
    match '/:id', via: [:get], to: 'resources#show'
  end

  Rails.application.routes.draw do
    mount Facebook::Messenger::Server, at: 'bot'
  end

  resources :articles, only: [:show], path: '', as: 'articles_show'
  resources :resources, only: [:show], path: '', as: 'resources_show'
end
