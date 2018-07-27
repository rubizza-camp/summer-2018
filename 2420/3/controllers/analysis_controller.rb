# class AnalysisController
class AnalysisController < ApplicationController
  get '/:id' do
    @id = params[:id]
    @first_id = Article[@id].comments.first.id
    @last_id = Article[@id].comments.last.id
    erb :analysis
  end

  post '/:id' do
    erb :analysis
  end
end
