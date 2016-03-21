class Question < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :question_votes
  has_many :answers

  def get_vote (user)
    @vote = QuestionVote.find_by(user: user, question: self)
  end

  def is_voted_up(user)
    vote = get_vote user
    if vote==nil
      result = false
    else
      result = vote.action
    end
    result
  end

  def is_voted_down(user)
    vote = get_vote user
    if vote==nil
      result = false
    else
      result = !vote.action
    end
    result
  end

  def vote_up(user)
    self.rating+=1
    vote = QuestionVote.new(action: true, user: user, question: self)
    transaction do
      vote.save
      self.save
    end
  end

  def vote_clear(question_vote)
    if question_vote.action
      self.rating-=1
    else
      self.rating+=1
    end
    transaction do
      question_vote.destroy
      self.save
    end
  end

  def vote_down(user)
    self.rating-=1
    vote = QuestionVote.new(action: false, user: user, question: self)
    transaction do
      vote.save
      self.save
    end
  end

end
