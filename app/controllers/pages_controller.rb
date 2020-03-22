class PagesController < ApplicationController
  def index
    @questionnaire = Questionnaire.new
    cookies.permanent.encrypted[:client_uuid] ||= SecureRandom.uuid
  end
end
