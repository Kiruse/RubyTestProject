Rails.application.routes.draw do
	namespace :api do
		get '/api/ticket/:barcode/may_leave', to: 'tickets#may_leave'
		
		resources :tickets, only: [:index, :create, :new, :show], param: :barcode do
			resource :payment, only: [:new, :create]
		end
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
