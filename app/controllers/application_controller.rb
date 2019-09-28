class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "frank", password: "123456"
end
