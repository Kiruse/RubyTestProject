Rails.application.routes.draw do
	
	namespace :api do
		get '/free-spaces', to: 'tickets#free_spaces'
		
		resources :tickets, only: [:index, :create, :new, :show], param: :barcode do
			resource :payment, only: [:new, :create]
		end
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
