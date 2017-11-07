class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/new'
  end

  post '/figures' do
    if params[:figure][:id]
      figure = Figure.find(params[:figure][:id])
      figure.name = params[:figure][:name]
    else
      figure = Figure.find_or_create_by(name: params[:figure][:name])
    end

    if !params[:landmark][:name].empty?
      figure.landmarks.build(params[:landmark])
    elsif params[:figure][:landmark_ids]
      figure.landmark_ids = (params[:figure][:landmark_ids])
    end

    if !params[:title][:name].empty?
      figure.titles.build(params[:title])
    else params[:figure][:title_ids]
      figure.title_ids = (params[:figure][:title_ids])
    end
    figure.save

    redirect to :"/figures/#{figure.id}"
  end

  post '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.name = params[:figure][:name]

    if !params[:landmark][:name].empty?
      figure.landmarks.build(params[:landmark])
    elsif params[:figure][:landmark_ids]
      figure.landmark_ids = (params[:figure][:landmark_ids])
    end

    if !params[:title][:name].empty?
      figure.titles.build(params[:title])
    else params[:figure][:title_ids]
      figure.title_ids = (params[:figure][:title_ids])
    end
    figure.save

    redirect to :"/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/figures"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :"/figures/edit"
  end

end
