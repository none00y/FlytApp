class Passenger < ApplicationRecord
  belongs_to :airplane, optional: true

  validates_presence_of :first_name
  validates_presence_of :last_name

  validate :first_name_has_proper_format
  validate :last_name_has_proper_format

  def first_name_has_proper_format
    return if first_name.blank? || first_name.match(/^[A-Z][a-z ,.'-]+$/i)

    errors.add(:first_name, 'Has improper format')
  end

  def last_name_has_proper_format
    return if last_name.blank? || last_name.match(/^[A-Z][a-z ,.'-]+$/i)

    errors.add(:last_name, 'Has improper format')
  end

  enum state: {
    free: 0,
    in_airplane: 1
  }

  STATES = states.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_states
    STATES
  end
end
