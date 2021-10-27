class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @records = search_for(@content)
  end

  private

  def search_for(content)
    User.where('name LIKE ?', "%#{content}%")
  end
end
