Dir['Models/*.rb'].each { |file| load(file) }

require_relative 'command_proccessor.rb'
# Disabled because main function is entrypoint and class using not necessary
# rubocop:disable Style/MixinUsage
include CommandProccessor
# rubocop:enable Style/MixinUsage

def main
  raise ArgumentError, 'No valid keys. Using key "--help" to help.' unless CommandProccessor.check_arguments(ARGV)
  CommandProccessor.send_command(ARGV)
rescue ArgumentError => error
  puts("Incorrect data. #{error.message}")
rescue NotImplementedError
  puts('That functional is not realize yet.')
end

main
