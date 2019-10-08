class CometChatService
  include HTTParty
  BASE_URI = 'https://api.cometchat.com/v1'.freeze

  def initialize(params = nil)
    @params = params
  end

  def create_user
    body = {
      uid: params[:uid],
      name: params[:name]
    }
    puts(body)
    response = HTTParty.post("#{BASE_URI}/users", headers: headers, body: body)
    puts("FROM CREATE USER")
    puts(response)
    response.dig('data')
  end

  def fetch_users
    response = HTTParty.get("#{BASE_URI}/users", headers: headers)
    response.dig('data')
      &.map { |u| { name: u['name'], id: u['uid'] } }
  end

  private

  attr_accessor :params

  def headers
    {
      apikey: ENV['COMETCHAT_API_KEY'],
      appid: ENV['COMETCHAT_APP_ID']
    }
  end
end
