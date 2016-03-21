class User < ActiveRecord::Base
  has_many :questions
  has_many :comments
  has_many :question_votes
  has_many :answer_votes
  has_many :answers

  def full_name
    @full_name = first_name+' '+last_name
  end

end
