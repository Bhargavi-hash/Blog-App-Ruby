class Article < ApplicationRecord
    include Visible

    belongs_to :user

    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 1 }
    validates :text, presence: true, length: { minimum: 1 }

    private 

    def election_influence_validation
        if title.match?(/\b(Trump|Harris)\b/i)
            errors.add(:title, "cannot comtain election-influencing terms.")
        end
    end
end
