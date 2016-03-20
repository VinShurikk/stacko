class Tag < ActiveRecord::Base

  def self.search(term)
    @search_tags = Tag.where('LOWER(text) LIKE :term', term: "#{term.downcase}%")
    # @search_tags += Tag.where('LOWER(text) LIKE :term', term: "%#{term.downcase}%")
  end
end
