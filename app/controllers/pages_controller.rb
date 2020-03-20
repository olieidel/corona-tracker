class PagesController < ApplicationController
  def index
    @questionnaire = Questionnaire.new
    # @questionnaire.build_browser_location
    cookies.permanent.encrypted[:client_uuid] ||= SecureRandom.uuid
  end
end
