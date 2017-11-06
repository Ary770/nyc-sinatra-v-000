class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.new(name: params[:figure][:name])

    if !params[:landmark][:name].empty?
      figure.build_landmark(params[:landmark])
    elsif params[:figure][:landmark_ids]
      figure.landmark_ids = (params[:figure][:landmark_ids])
    end

    if !params[:title][:name].empty?
      figure.build_title(params[:title])
    else params[:figure][:title_ids]
      figure.title_ids = (params[:figure][:title_ids])
    end
    figure.save
  end

end
