require 'octokit'
require 'json'

class Git_api_class
    
    def initialize(username,password)
        @username = username
        @password = password
    end

    def get_api_data(date)
        client = Octokit::Client.new(:login => @username, :password => @password)
        # p client.user
        # p client.user.email
        repos = client.repositories
        info = {}
        repos.each do |repo|
            # p repo.full_name
            commit_date = {}
            client.branches("#{repo.full_name}").each do |branch|
                commits = client.commits_since("#{repo.full_name}" ,date ,branch['name'])
                # p commits
                # p branch['name']
                # p commits.first
                # p commits.first.sha
                # p commits.first.commit.message
                # p client.user.login
                # p client.branches("#{repo.full_name}")
                commits.each do |x|
                    arr = []
                    # p x.author.login
                    if x.author.login == client.user.login
                        # if x.commit.author.name == client.user.login || x.commit.author.name == client.user.name || x.commit.author.email == client.user.email || x.commit.committer.name == "GitHub"
                        data = {}
                        data['branch'] = branch['name']
                        data['message'] = x.commit.message
                        data['sha'] = x.sha
                        # p "#{data} data is here"
                        arr << data
                        
                        # p time
                        time = x.commit.author.date.to_s.split(" ")[0]
                        commit_date["#{time}"] =+ arr
                    end
                end
            end
            info["#{repo.name}"] = commit_date
        end
        p info
        info
    end
end
