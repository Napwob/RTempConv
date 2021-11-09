# frozen_string_literal: true

require 'singleton'

class IOAdapter
  include Singleton

  def write(str)
    puts str
  end

  def read
    gets.chomp
  end
end
