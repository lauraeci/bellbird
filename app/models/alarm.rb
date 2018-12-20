class Alarm < ApplicationRecord
  after_create :push_to_handshake
  before_create :format_text
  has_many :votes

  def push_to_handshake
    response = HTTParty.post("https://bellbird.joinhandshake-internal.com/push",
                  {
                      :body => {"alarm_id" => id, "text" => text}.to_json,
                      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
                  })
    case response.code
    when 200
      logger.info "Post to handshake success"
    when 404
      logger.error "Not found!"
    when 500...600
      logger.error "ERROR #{response.code}"
    end
  end

  def format_text
    self.text = self.text.upcase
  end
end
