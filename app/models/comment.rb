class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :abusive, type: Boolean, default: false
  field :vote_uniqueness, type: Boolean

  validates_presence_of :body

  belongs_to :user
  belongs_to :post

  has_many :votes

  def votes_value
    votes_count = 0
    votes.each do |vote|
      votes_count = votes_count + vote.value
    end
    votes_count
  end

  def negative_votes_count
    negative_votes = 0
    votes.each do |vote|
      if vote.value == -1
        negative_votes = negative_votes + 1
      end
    end
    negative_votes
  end

  def check_abusiveness
    if negative_votes_count == 3
      self.abusive = true
      save
    end
  end


end
