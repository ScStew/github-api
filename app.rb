require 'sinatra'
require 'octokit'
require_relative 'git_octo.rb'
enable :sessions


get "/" do
    erb :login
end
    
post "/after_login" do
    session[:username] = params[:username]
    session[:pass] = params[:pass]
    session[:date] =  params[:date]
    redirect "/next_page"
end

get "/next_page" do
    user = session[:username]
    pass = session[:pass]
    date = session[:date]
    git_class = Git_api_class.new(user, pass)
    data = git_class.get_api_data("#{date}")
    p data
   erb :next_page, locals: {data:data}
end
