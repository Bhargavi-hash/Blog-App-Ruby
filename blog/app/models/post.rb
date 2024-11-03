class Post < ApplicationRecord
    include Visible

    belongs_to :user

    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 1 }
    validates :text, presence: true, length: { minimum: 1 }

    private 

    def election_influence_validation
        if title.downcase.include?('trump') || body.downcase.include?('harris')
          errors.add(:title, "cannot contain election-influencing terms.")
        end
        if text.downcase.include?('trump') || body.downcase.include?('harris')
            errors.add(:text, "cannot contain election-influencing terms.")
        end
    end
end
