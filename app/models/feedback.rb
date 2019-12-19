class Feedback < ApplicationRecord
  enum gender: ["Male", "Female"]
  enum profession: ["Student", "Employed", "Self-Employed", "Unemployed"]
  enum hear_through: ["Friends and Family", "Advertising", "Social Media", "Other, please specify"], _prefix: :hear
  enum preference: ["Eat-in", "Eat-out", "Have your food delivered"]
  enum experience: ["Positive", "Neutral", "Negative"]
  enum contact_through: ["Email", "SMS", "Social Media"], _prefix: :contact

  validates_presence_of :name, :email, :mobile_number, :gender, :profession, :hear_through, :preference, :experience, :contact_through, :comments
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

end
