class Api::SuppliersController < ApplicationController
  def index
    render 'index.json.jb'
  end
end
