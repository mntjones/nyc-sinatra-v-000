require 'pry'

class FiguresController < ApplicationController
   set :views, Proc.new { File.join(root, "../views/figures") }

   get '/figures' do
     @figures = Figure.all
     erb :index
   end

   get '/figures/new' do
     @titles = Title.all
     @landmarks = Landmark.all
     erb :new
   end

   post '/figures' do
     @figure = Figure.create(name: params["figure"]["name"])

     @title_ids = params["figure"]["title_ids"]

     if !params["title"]["name"].empty?
       @figure.titles << Title.create(name: params["title"]["name"])
     end

     if @title_ids
       @title_ids.each do |id|
         title = Title.find_by_id(id)
         @figure.titles << title
       end
     end

     @landmark_ids = params["figure"]["landmark_ids"]

     if !params["landmark"]["name"].empty?
       @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
     end

     if @landmark_ids
       @landmark_ids.each do |id|
         landmark = Landmark.find_by_id(id)
         @figure.landmarks << landmark
       end
     end
     @figure.save
     erb :show
   end

   get '/figures/:id/edit' do
     @figure = Figure.find_by_id(params[:id])
     @landmarks = Landmark.all
     @titles = Title.all
     erb :edit
   end

   post '/figures/:id' do

     @figure = Figure.find_by_id(params[:id])

     @figure.name = params["figure"]["name"]

     @title_ids = params["figure"]["title_ids"]
     
     if @title_ids
       @figure.titles.clear
       @title_ids.each do |id|
         title = Title.find_by_id(id)
         @figure.titles << title
       end
     end
     if !params["title"]["name"].empty?
       @figure.titles << Title.create(name: params["title"]["name"])
     end

     @landmark_ids = params["figure"]["landmark_ids"]

     if @landmark_ids
       @figure.landmarks.clear
       @landmark_ids.each do |id|
         landmark = Landmark.find_by_id(id)
         @figure.landmarks << landmark
       end
     end

     if !params["landmark"]["name"].empty?
       @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
     end

     @figure.save
     erb :show
    end

    get "/figures/:id" do
     @figure = Figure.find_by_id(params[:id])
     erb :show
    end

 end
