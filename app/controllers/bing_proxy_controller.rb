require 'net/http'

class BingProxyController < ApplicationController
  def get
    root_uri = 'https://api.datamarket.azure.com/Bing/Search/Web'
    account_key = ENV['AZURE_KEY']
    uri = URI(root_uri)
    get_params = {"$format" => "json",
                  "Query" => "'#{params[:query]}'",
                  "Market" => "'en-us'",
                  "$top" => 5}
    uri.query = URI.encode_www_form(get_params)

    req = Net::HTTP::Get.new(uri)
    req.basic_auth account_key, account_key

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
      https.request(req)
    end

    render :json => res.body
  end
end
