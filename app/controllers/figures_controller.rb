require "pry"

class FiguresController < ApplicationController

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    end
    if !params[:title][:name].empty?
      new_title = Title.create(name: params[:title][:name])
      FigureTitle.create(title: new_title, figure: @figure)
      binding.pry
    end
    @figure.save
    # binding.pry
    redirect "/figures/#{@figure.id}"
  end

  get '/figure/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

end
