require 'simplecov'
SimpleCov.start
require_relative '../command_line.rb'

describe CommandLine do
  it 'is able to be created' do
    command_line = CommandLine.new
    expect(command_line.options).to be_kind_of(Hash)
  end

  it 'has instance variable @options of type Hash' do
    command_line = CommandLine.new
    expect(command_line.options).to be_kind_of(Hash)
  end
end
