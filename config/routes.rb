Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  root "pages#home"

  get "/admin" => "pages#admin"

  resources :pages
  resources :articles, except: [:show]
  resources :articles, :only => [:show], :path => '', as: "articles_show"


  # get 'services' => "pages#services"
  #
  # get 'newsletter' => "pages#newsletter"
  #
  # get 'about' => "pages#about"
  #
  # get 'thanks' => "pages#thanks"
  #
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
