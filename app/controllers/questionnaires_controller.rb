class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]

  # GET /questionnaires
  # GET /questionnaires.json
  def index
    @questionnaires = Questionnaire.sliding_window(where_simulated: false)
  end

  # POST /questionnaires
  # POST /questionnaires.json
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.client_uuid = cookies.encrypted[:client_uuid]

    respond_to do |format|
      if @questionnaire.save
        format.js
      else
        format.html { render :new }
      end
    end
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(:healthy, :tested, :fever, :cough, :other_symptoms,
                                          :latitude, :longitude, :accuracy)
  end
end
