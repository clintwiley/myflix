class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :description


 def self.search_by_title(search_term)
 #  search_term.blank? ? where([]) : where(:all, conditions: ['title LIKE ?', "%#{search_term}%"]).order('created_at DESC')
   where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
 end
end
