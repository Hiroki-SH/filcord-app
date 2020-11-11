class ApplicationController < ActionController::Base
  include SessionsHelper #login関係のメソッドを記入したヘルパーをアプリケーション内全てで使用するため
end
