Wheresthesunshine::Application.routes.draw do
  get "weather/nearest_sunshine"

  get "tasks/update_conditions"
  
  root :to => 'pages#index'
end
