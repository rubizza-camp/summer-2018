# The Progress responsible for show progress
class Progress
  def initialize
    @threads = []
  end

  def show
    @threads << Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
  end

  def hide
    @threads.each(&:kill)
  end
end
