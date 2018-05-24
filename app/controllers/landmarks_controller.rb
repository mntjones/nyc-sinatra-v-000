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
  @landmark = Landmark.find_by_id(params[:id])
  erb :show
 end
 
 get '/landmarks/:id/edit' do
   @landmark = Landmark.find_by_id(params[:id])
   erb :edit
 end
 
 post '/landmarks/:id' do
   @landmark = Landmark.find_by_id(params[:id])
   @landmark.update(params["landmark"])
   title = Title.find_or_create_by(name: params["title"]["name"])
   @landmark.title = title
   @landmark.figure_ids = params["figures"]
   @landmark.save
   erb :show
 end
 
end
