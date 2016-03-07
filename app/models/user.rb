class User < ActiveRecord::Base

  def full_name
    @full_name = first_name+' '+last_name
  end
end
