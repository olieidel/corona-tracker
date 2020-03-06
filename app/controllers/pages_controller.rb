class PagesController < ApplicationController
  def index
    @questionnaire = Questionnaire.new
    @questionnaire.build_browser_location
  end
end
