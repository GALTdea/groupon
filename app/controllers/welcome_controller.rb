class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :is_legal

  def show
    render :text => params[:echostr]
  end

  def create
    @customer = Customer.find_by wxid: params[:xml]['FromUserName']
    @customer ?  (render 'unregistered', formats => :xml) :
          (render 'registered', formats => :xml)
  end

  def index
    render 'index'
  end

  private
    def is_legal
      array = [Rails.configuration.wx_token, params[:timestamp], params[:nonce]].sort
      render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
end
