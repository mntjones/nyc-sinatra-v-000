require 'pry'

class LandmarksController < ApplicationController
 set :views, Proc.new { File.join(root, "../views/landmarks") }

 get '/landmarks' do
  @landmarks = Landmark.all
   erb :index
 end

 get '/landmarks/new' do
   
   erb :new
 end
 
 post '/landmarks' do
   @landmark = Landmark.create(params["landmark"])
   title = Title.find_or_create_by(name: params["title"]["name"])
   @landmark.title = title
   @landmark.figure_ids = params["figures"]
   @landmark.save
   
   erb :show
 end
 
 get "/landmarks/:id" do
   binding.pry
  @landmark = Landmark.find_by_id(:id)
  
  erb :show
 end
 
end
