class SurveyQuestionsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  before_action :set_survey_question, only: [:show, :edit, :update, :destroy]

  # GET /survey_questions
  # GET /survey_questions.json
  def index
    # Loading all questions and answers, then attaching answers to quesitons
    # to minimize database calls
    @survey_questions = SurveyQuestion.all
    ordered_answers = SurveyAnswer.query_all_answers_order_by_question()

    # Assign answers to questions - questions ordered by id and answers should
    # be ordered by question id
    answer_idx = 0
    @survey_questions.each do |question|
      if answer_idx >= ordered_answers.length
        break
      end

      while answer_idx < ordered_answers.length and
          ordered_answers[answer_idx].survey_question_id == question.id do
        question.add_answer(ordered_answers[answer_idx])
        answer_idx += 1
      end
    end

  end

  # GET /survey_questions/1
  # GET /survey_questions/1.json
  def show

  end

  # GET /survey_questions/new
  def new
    @survey_question = SurveyQuestion.new
  end

  # GET /survey_questions/1/edit
  def edit
  end

  # POST /survey_questions
  # POST /survey_questions.json
  def create
    @survey_question = SurveyQuestion.new(survey_question_params)

    respond_to do |format|
      if @survey_question.save
        format.html { redirect_to @survey_question, notice: 'Survey question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @survey_question }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_questions/1
  # PATCH/PUT /survey_questions/1.json
  def update
    respond_to do |format|
      if @survey_question.update(survey_question_params)
        format.html { redirect_to survey_questions_path, notice: 'Survey question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @survey_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_questions/1
  # DELETE /survey_questions/1.json
  def destroy
    @survey_question.destroy
    respond_to do |format|
      format.html { redirect_to survey_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_question
      @survey_question = SurveyQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_question_params
      params.require(:survey_question).permit(:question_text)
    end
end
