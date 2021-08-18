require 'rubygems'
require 'excon'
require 'json'

module ZendeskHelper
  def create_zd_ticket(data_source, type)
    @ticket_priority = type == 'question' ? 'normal' : 'high'

    @request_body = {
      "ticket": {
        "subject": "#{data_source.ticket_subject}",
        "type": "#{type}",
        "priority": "#{@ticket_priority}",
        "comment": { "html_body": "#{data_source.ticket_body}" },
        "requester": {
          "name": "#{data_source.full_name}", "email": "#{data_source.email}"
        },
        "custom_fields": [
          { "id": 360_054_575_513, "value": "#{data_source.phone}" }
        ]
      }
    }

    begin
      connection =
        Excon.new(
          "https://www.insert_zendesk_url_here.com/api/v2/tickets.json",
          debug_request: true, debug_response: true
        )
      connection.request(
        # interval is in seconds, this will block the client so leaving the limit and interval low
        method: 'POST',
        idempotent: true,
        expects: [200, 201],
        retry_limit: 2,
        retry_interval: 0.5,
        body: JSON.generate(@request_body),
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{ENV['ZD_AUTH']}"
        },
        instrumentor: ActiveSupport::Notifications
      ) # ActiveSupport::Notifications is for logging of requests and responses
    rescue Excon::Error => e
      puts "
      Warning: #{@ticket_subject} id # #{
             data_source.id
           } could not be sent to Zendesk. Please notify an administrator.
           Error: #{e}
           "
    end
  end

  def ticket_query(search_string, params)
    # params could be something like 'search' or 'search/count' to get the count only
    response =
      Excon.get(
        "#{ENV['ZD_URL']}/api/v2/#{params}.json?query=#{search_string}",
        headers: { 'Authorization' => "Basic #{ENV['ZD_AUTH']}" }
      )
    return JSON.parse(response.body)
  end
end
