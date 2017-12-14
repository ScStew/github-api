require 'octokit'
require 'json'

class Git_api_class
    
    def initialize(username,password)
        @username = username
        @password = password
    end

    def get_api_data(date)
        client = Octokit::Client.new(:login => @username, :password => @password)
        repos = client.repositories
        info = {}
        repos.each do |repo|
            # p repo.full_name
            commits = client.commits_since("#{repo.full_name}",date)
            # p commits.first
            # p commits.first.sha
            # p commits.first.commit.message
            data = {}
            commits.each do |x|
                data['repo_name'] = repo.name
                data['date'] = x.commit.author.date
                data['message'] = x.commit.message
                data['sha'] = x.sha
                # p info.count
                info["#{x.sha}"] = data
            end
        end
        info
    end
end







