# frozen_string_literal: true

require 'russian_obscenity'

# Represents a word from a battle
class String
  OBSCENITY_MARKER = '*'.freeze
  SPACES = %r{ |\/n}

  def only_spaces?
    gsub(SPACES, '').empty?
  end

  def obscene?
    include?(OBSCENITY_MARKER) || RussianObscenity.obscene?(self)
  end
end
