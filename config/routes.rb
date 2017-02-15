Rails.application.routes.draw do
  # ------------------ Static Pages -----------------------
  # Private
  get '/admin' => 'pages#admin'
  # Public
  root 'pages#home'
  get 'blog' => 'pages#blog'
  get 'services' => 'pages#services'
  get 'newsletter' => 'pages#newsletter'
  get 'about' => 'pages#about'
  get 'thanks' => 'pages#thanks'
  get '/search' => 'pages#search'

  # ------------------ Model Routing -----------------------
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_up: 'register' }
  resources :pages, :categories,:articles, :resources

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
      match '/:id', :via => [:get], to: "articles#show",  as: "articles_show"
    end

    class ResourceUrlConstrainer
      def matches?(request)
        id = request.path[1..-1]
        Resource.find_by_slug(id)
      end
    end

    constraints(ResourceUrlConstrainer.new) do
      match '/:id', :via => [:get], to: "resources#show", as: "resources_show"
    end

    resources :articles, :only => [:show], :path => '', as: "articles_show"
    resources :resources, :only => [:show], :path => '', as: "resources_show"

    match "*path",  :via => [:get], to: "locale#not_found"

# Maxime routing (old)

  # get 'apprendre-cmo-slack' => "pages#apprendre-cmo-slack"
  #
  # get 'experience-developpeur-mailjet' => "pages#experience-developpeur-mailjet"
  #
  # get 'chiffres-retention-applications-mobiles' => "pages#chiffres-retention-applications-mobiles"
  #
  # get 'croissance-etsy-analyse' => "pages#croissance-etsy-analyse"
  #
  # get 'alex-schultz-vp-growth-facebook' => "pages#alex-schultz-vp-growth-facebook"
  #
  # get 'culture-data-zynga' => "pages#culture-data-zynga"
  #
  # get 'non-growth-hacking' => "pages#non-growth-hacking"
  #
  # get 'mauvaise-retention' => "pages#mauvaise-retention"
  #
  # get 'from-zero-to-one-point-two' => "pages#from-zero-to-one-point-two"
  #
  # get 'produit-levier-croissance' => "pages#produit-levier-croissance"
  #
  # get 'dette-analytics' => "pages#dette-analytics"
  #
  # get '16-metriques-startups' => "pages#16-metriques-startups"
  #
  # get 'vraie-strategie-croissance' => "pages#vraie-strategie-croissance"
  #
  # get 'utilisation-feedbacks-slack' => "pages#utilisation-feedbacks-slack"
  #
  # get 'brian-balfour-discute-growth-marketing' => "pages#brian-balfour-discute-growth-marketing"
  #
  # get 'premiere-campagne-acquisition-payante' => "pages#premiere-campagne-acquisition-payante"
end
