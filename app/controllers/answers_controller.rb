class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    question = Question.find(@answer.question_id)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(question, anchor: "#{@answer.id}_answer"), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote_up
    answer_vote = get_vote
    user = current_user
    if answer_vote==nil
      @answer.vote_up user
    else
      if !answer_vote.action
        @answer.vote_clear answer_vote
      end
    end
    respond_to do |format|
      format.js {render 'answers/update_side'}
    end
  end

  def vote_down
    answer_vote = get_vote
    user = current_user
    if answer_vote==nil
      @answer.vote_down user
    else
      if answer_vote.action
        @answer.vote_clear answer_vote
      end
    end
    respond_to do |format|
      format.js {render 'answers/update_side'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def get_vote
      AnswerVote.find_by(user: current_user, answer: @answer)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:question_id, :text)
    end
end
