class Url < ActiveRecord::Base
  validates :long, uniqueness: true, presence: true
  validate :validate_url
  before_save :key

  # before_save :validate_url

  def key
    self.shortened = SecureRandom.hex(3) unless self.shortened?
  end

  def validate_url
    prefix = 'http://'
    secure_prefix = 'https://'

    unless self.long[0...7].downcase == prefix || self.long[0...8].downcase == secure_prefix
      self.long = prefix + self.long
    end

    unless self.long =~ /^[a-zA-Z]+:\/\//
      errors.add(:long, "Please enter a valid URL beginning with 'http://' or 'https://'")
    end
  end

end


