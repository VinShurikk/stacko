class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    puts @question.tags.length
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @tag_params = params[:tags_list]
    @tags = Tag.where(:text => @tag_params)
    Question.transaction do
      if @tag_params.length>@tags.length
        @tag_params.each do |tag_param|
          tag = Tag.where(:text => tag_param)
          if tag.empty?
            logger.debug "Tag #{tag_param} not found"
            tag_to_save = Tag.new
            tag_to_save.text = tag_param
            tag_to_save.save
            @tags << tag_to_save
          else
            logger.debug "Tag #{tag.inspect} found"
          end
        end
      end
      @question.tags << @tags
      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @tags = Tag.where(:id => params[:question_tags])
    @question.tags.destroy_all
    @question.tags << @tags
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote_up
    question_vote = get_vote
    user = current_user
    if question_vote==nil
      @question.vote_up user
    else
      if !question_vote.action
        @question.vote_clear question_vote
      end
    end
    respond_to do |format|
      format.js {render 'questions/update_side'}
    end
  end

  def vote_down
    question_vote = get_vote
    user = current_user
    if question_vote==nil
      @question.vote_down user
    else
      if question_vote.action
        @question.vote_clear question_vote
      end
    end
    respond_to do |format|
      format.js {render 'questions/update_side'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def get_vote
      QuestionVote.find_by(user: current_user, question: @question)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :text, :rating, :tags)
    end
end
