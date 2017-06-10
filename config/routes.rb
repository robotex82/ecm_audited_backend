Ecm::Audited::Backend::Engine.routes.draw do
  resources :audit_logs, only: [:index, :show]

  root to: 'home#index'
end