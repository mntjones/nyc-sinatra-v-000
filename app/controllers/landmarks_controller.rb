class LandmarksController < ApplicationController
 set :views, Proc.new { File.join(root, "../views/landmarks") }

 get '/' do

   erb :index
 end

 get '/landmarks/new' do
   
   erb :new
 end
end
