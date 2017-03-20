Rails.application.routes.draw do
  # Sitemap
  get '/sitemap.xml.gz', to: redirect("https://s3-eu-west-1.amazonaws.com/thegrowthbakeryblog/sitemap.xml.gz")
  # ------------------ Static Pages -----------------------
  # Private
  get '/admin' => 'pages#admin'
  # Public
  root 'pages#home'
  get '/blog' => 'pages#blog'
  get '/services' => 'pages#services'
  get '/newsletter' => 'pages#newsletter'
  get '/about' => 'pages#about'
  get '/thanks' => 'pages#thanks'
  get '/search' => 'pages#search'
  get '/contact' => 'pages#contact'

  # Redirect the errors
  %w( 404 500 ).each do |code|
    match code, :to => "errors#show",:code => code, :via => :all
  end
  # ------------------ Model Routing -----------------------
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_up: 'register' }
  resources :pages, :categories, :topics, :articles, :resources
  resources :contactforms, only: [:new, :create]

  get "search/:id" => "pages#search", as: "resource_category"


=begin
This routes articles and resources. First it searches for a matching article by slug (friendly id), then
falls down to resources. Ex;
www.mysite.com/this-is-the-title-of-the-article  (articles#show)
www.mysite.com/cool-new-resource (resources#show)
=end
    class ArticleUrlConstrainer
      def matches?(request)
        id = request.path[1..-1]
        Article.find_by_slug(id)
      end
    end

    constraints(ArticleUrlConstrainer.new) do
      match '/:id', :via => [:get], to: "articles#show"
    end

    class ResourceUrlConstrainer
      def matches?(request)
        id = request.path[1..-1]
        Resource.find_by_slug(id)
      end
    end

    constraints(ResourceUrlConstrainer.new) do
      match '/:id', :via => [:get], to: "resources#show"
    end

    resources :articles, :only => [:show], :path => '', as: "articles_show"
    resources :resources, :only => [:show], :path => '', as: "resources_show"
end
