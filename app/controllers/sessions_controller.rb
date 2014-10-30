class SessionsController < ApplicationController
  def create
    render text: "", layout: 'layouts/application'
  end

  def destroy
  end
end
