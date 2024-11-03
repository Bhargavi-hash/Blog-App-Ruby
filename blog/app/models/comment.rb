class Comment < ApplicationRecord
  include Visible

  belongs_to :post
  belongs_to :user

  validates :body, presence: true
  validate :election_influence_validation

  private

  def election_influence_validation
    if body.downcase.include?('trump') || body.downcase.include?('harris')
      errors.add(:body, "cannot contain election-influencing terms.")
    end
  end
end
