require 'faraday'
require 'json'

class UserCommits
    def initialize(username)
        @username = username
    end

    def github_url
        "https://api.github.com/users/#{@username}/events"
    end

    def get_api_data
        response = Faraday.get(github_url)
        JSON.parse(response.body)
    end

    def get_commits

    end
end


