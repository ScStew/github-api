require 'sinatra'
require 'octokit'
enable :sessions


get "/" do
    erb :login
end
    
post "/after_login" do
    session[:username] = params[:username]
    session[:pass] = params[:pass]
    redirect "/next_page"
end

get "/next_page" do
    u = session[:username]
    p = session[:pass]
    client = Octokit::Client.new(:login => u, :password => p)
    # user = client.user
    # p user.path
    commits = client.commits_since('ScStew/valid_isbn','2016-11-01')
    commits.each do |x|
        p x
        
        
    end
end
