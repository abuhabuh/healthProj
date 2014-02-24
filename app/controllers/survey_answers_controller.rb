class SurveyAnswersController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  before_action :set_param_vars

  # GET /survey_answers
  # GET /survey_answers.json
  def index
    @survey_answers = SurveyAnswer.all
  end

  # GET /survey_answers/1
  # GET /survey_answers/1.json
  def show
  end

  # GET /survey_answers/new
  def new
    @survey_answer = SurveyAnswer.new
  end

  # GET /survey_answers/1/edit
  def edit
    @survey_question = SurveyQuestion.find(@survey_question_id)
    if @survey_question.nil?
      redirect_to survey_questions_path, notice: 'Technical Error: survey question not found'
    end
  end

  # POST /survey_answers
  # POST /survey_answers.json
  def create
    @survey_answer = SurveyAnswer.new(survey_answer_params)
    @survey_answer.survey_question_id = @survey_question_id

    respond_to do |format|
      if @survey_answer.save
        format.html { redirect_to survey_questions_path, notice: 'Survey answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @survey_answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_answers/1
  # PATCH/PUT /survey_answers/1.json
  def update
    respond_to do |format|
      if @survey_answer.update(survey_answer_params)
        format.html { redirect_to survey_questions_path, notice: 'Survey answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @survey_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_answers/1
  # DELETE /survey_answers/1.json
  def destroy
    @survey_answer.destroy
    respond_to do |format|
      format.html { redirect_to survey_questions_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_param_vars
      # set survey question id that answers are a part of (should always be
      # present in the url path)
      @survey_question_id = params[:survey_question_id]

      # set survey answer
      @survey_answer = nil
      if params.has_key?(:id)
        @survey_answer = SurveyAnswer.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_answer_params
      params.require(:survey_answer).permit(:answer_text, :answer_value, :survey_question_id)
    end
end
