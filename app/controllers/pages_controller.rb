class PagesController < ApplicationController
  def home
    @tests = Test.all
  end
end
