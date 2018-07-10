class TerminalColors
  OKBLUE = "\033[94m".freeze
  OKGREEN = "\033[92m".freeze
  ENDC = "\033[0m".freeze
end

class ReekFix
  METHOD_PATTERN = 'def test_'.freeze
  CLASS_PATTERN = '< Neo::Koan'.freeze
  REEK_PATTERN = ':reek:'.freeze

  REEK_METHOD_NAME_FIX = '# This method smells of ' \
                           ":reek:UncommunicativeMethodName\n".freeze

  REEK_VARIABLE_NAME_FIX = '# This method smells of ' \
                             ":reek:UncommunicativeVariableName\n".freeze

  REEK_STATEMENT_FIX = '# This method smells of ' \
                         ":reek:TooManyStatements\n".freeze

  REEK_FEATURE_ENVY_FIX = '# This method smells of ' \
                            ":reek:FeatureEnvy\n".freeze

  REEK_CLASS_NAME_FIX = '# This class smells of ' \
                          ":reek:UncommunicativeModuleName\n".freeze

  REEK_METHOD_FIXES = [
    REEK_METHOD_NAME_FIX,
    REEK_VARIABLE_NAME_FIX,
    REEK_STATEMENT_FIX,
    REEK_FEATURE_ENVY_FIX
  ].freeze

  REEK_CLASS_FIXES = [
    REEK_CLASS_NAME_FIX
  ].freeze
end

def fix_entry(entry, index, fixes)
  class_changed = false
  existed_fixes = []
  while (index - existed_fixes.size - 1 >= 0) && @lines[index - existed_fixes.size - 1].include?(ReekFix::REEK_PATTERN)
    existed_fixes << @lines[index - existed_fixes.size - 1].lstrip
  end

  fixes.each do |fix|
    unless existed_fixes.include? fix
      @content_to_write << ' ' * (entry.size - entry.lstrip.size) + fix
      class_changed = true
    end
  end
  class_changed
end

def write_log(koan_file, file_changed)
  if file_changed
    puts "#{TerminalColors::OKBLUE}modified - #{koan_file}#{TerminalColors::ENDC}"
  else
    puts "#{TerminalColors::OKGREEN}no changes - #{koan_file}#{TerminalColors::ENDC}"
  end
end

Dir.glob(ARGV[0]) do |koan_file|
  @content_to_write = []
  File.open koan_file, 'r+' do |f|
    @lines = f.readlines
    file_changed = false
    @lines.each_with_index do |line, index|
      if line.include? ReekFix::METHOD_PATTERN
        file_changed |= fix_entry line, index, ReekFix::REEK_METHOD_FIXES
      elsif line.include? ReekFix::CLASS_PATTERN
        file_changed |= fix_entry line, index, ReekFix::REEK_CLASS_FIXES
      end
      @content_to_write << line
    end
    write_log koan_file, file_changed
  end

  File.open(koan_file, 'w') { |f| f.puts @content_to_write }
end
