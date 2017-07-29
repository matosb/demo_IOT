class PagesController < ApplicationController
  def home
    @tests = Test.order(created_at: :desc)
  end
end
