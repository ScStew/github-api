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
        info = []
        repos.each do |repo|
            # p repo.full_name
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
                    # p x.commit.committer.name
                    if x.commit.author.name == client.user.login || x.commit.committer.name == "GitHub"
                        data = {}
                        data['repo_name'] = repo.name
                        data['branch'] = branch['name']
                        data['author'] = x.commit.author.name
                        data['date'] = x.commit.author.date
                        data['message'] = x.commit.message
                        data['sha'] = x.sha
                        # p "#{data} data is here"
                        info << data
                    end
                end
            end
        end
        info
    end
end







