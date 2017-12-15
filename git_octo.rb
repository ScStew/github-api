require 'octokit'
require 'json'

class Git_api_class
    
    def initialize(username,password)
        @username = username
        @password = password
    end

    def get_api_data(date)
        client = Octokit::Client.new(:login => @username, :password => @password)
        p client.user.email
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
                arr = []
                commits.each do |x|
                    p x
                    if x.commit.author.email == client.user.email
                        data = {}
                        data['branch'] = branch['name']
                        data['message'] = x.commit.message
                        data['sha'] = x.sha
                        # p "#{data} data is here"
                        arr << data
                    time = x.commit.author.date.to_s.split(" ")[0]
                    # p time
                    commit_date["#{time}"] = arr
                    info["#{repo.name}"] = commit_date
                    end
                end
            end
        end
     info
    end
end
