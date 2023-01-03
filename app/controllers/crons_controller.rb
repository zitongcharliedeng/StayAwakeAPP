class CronsController < ApplicationController
  require 'rest-client'

  # This only needs to be called the first time we add a new user
  # We will call it manually for now (e.g. via postman) to store their first set of session_token and access_token credentials in DB
  # Once this first set of tokens is stored, all subsequent attempts to authenticate will use the tokens stored in DB
  def first_time_authentication
    user_id = parse_param(param, "user_id")
    session_token = parse_param(param, "session_token")
    refresh_token = parse_param(param, "refresh_token")
    session_token_expiry = parse_param(param, "session_token_expiry")

    User.new  
  end

  def start
    user_id = "fillIn"
    access_token = "fillIn"
    date = Time.now.strftime("%Y/%m/%d") # date = YYYY/MM/DD
    res = RestClient.get("https://api.fitbit.com/1.2/user/#{user_id}/sleep/date/#{date}.json", headers={authorization: "Bearer #{access_token}"})
    p res.to_yaml
  end

  private
  def parse_param(params, key)
    param = params[key]
    if !param do
        raise "missing param #{key}"
    end

    return param
  end

end
