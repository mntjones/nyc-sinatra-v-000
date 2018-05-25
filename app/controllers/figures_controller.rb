require 'pry'

class FiguresController < ApplicationController
   set :views, Proc.new { File.join(root, "../views/figures") }

   get '/figures' do
     @figures = Figure.all
     erb :index
   end
  
   get '/figures/new' do
     erb :new
   end
   
   post '/figures' do
     @figure = Figure.create(params["figure"])
     @figure.title_ids = params["titles"]
     @figure.landmark_ids = params["landmarks"]
     @figure.save
     
     erb :show
   end
   
   get "/figures/:id" do
    @figure = Figure.find_by_id(params[:id])
    erb :show
   end
   
   get '/figures/:id/edit' do
     @figure = Figure.find_by_id(params[:id])
     erb :edit
   end
   
   post '/figures/:id' do
     @figure = Landmark.find_by_id(params[:id])
     @figure.update(params["figure"])
     @figure.title_ids = params["titles"]
     @figure.landmark_ids = params["landmarks"]
     @figure.save
     erb :show
    end
 end
