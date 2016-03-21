class Answer < ActiveRecord::Base
  belongs_to :user
  has_many :answer_votes

  def get_vote(user)
    @vote = AnswerVote.find_by(user: user, answer: self)
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
    vote = AnswerVote.new(action: true, user: user, answer: self)
    transaction do
      vote.save
      self.save
    end
  end

  def vote_clear(answer_vote)
    if answer_vote.action
      self.rating-=1
    else
      self.rating+=1
    end
    transaction do
      answer_vote.destroy
      self.save
    end
  end

  def vote_down(user)
    self.rating-=1
    vote = AnswerVote.new(action: false, user: user, answer: self)
    transaction do
      vote.save
      self.save
    end
  end
end
