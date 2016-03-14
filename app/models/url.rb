class Url < ActiveRecord::Base
  validates :long, uniqueness: true, presence: true
  validate :validate_url
  before_save :key

  # before_save :validate_url

  def key
    self.shortened = SecureRandom.hex(3) unless self.shortened?
  end

  def validate_url
   unless long =~ /\A#{URI::regexp(['http', 'https'])}\z/
      errors.add(:long, 'Needs to be a valid URL!')
    end
  end

end


