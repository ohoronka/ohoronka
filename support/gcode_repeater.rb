# require_relative Rails.root + 'support/gcode_repeater'

# shifts = [
#   {'X' => 0, 'Y' => 0},
#   {'X' => 20, 'Y' => 0}
# ]
#
# coder = GcodeRepeater.new(
#   f_in: '/Users/bguban/Dropbox/projects/ohoronka/milling_test/result.nc',
#   f_out: '/Users/bguban/Dropbox/projects/ohoronka/milling_test/result_shifted.nc',
#   shifts: shifts
# )
# coder.run


class GcodeRepeater
  attr_accessor :f_in, :f_out, :shifts, :pre, :post

  def run
    File.open(f_out, 'w') do |out|
      out.puts pre if pre
      shifts.each do |shift|
        File.foreach(f_in) do |line|
          cmd = Command.new(line)
          cmd.shift(shift)
          out.puts cmd.to_s
        end
      end
      out.puts post if post
    end
  end

  def build_matrix(nx, ny, dx, dy)
    self.shifts = []
    nx.times do |ix|
      ny.times do |iy|
        shifts << {'X' => ix * dx, 'Y' => iy * dy}
      end
    end
  end
end

class Command
  attr_accessor :cmd, :options, :line

  def initialize(line)
    @line = line
    parse
  end

  def shift(params)
    params.each do |key, delta|
      val = options[key] || next
      options[key] = val + delta
    end
  end

  def to_s
    opt_string = options.map do |key, val|
      val_str = val.instance_of?(Integer) ? val.to_s : sprintf("%.3f", val)
      key.to_s + val_str
    end.join(' ')

    "#{cmd} #{opt_string}"
  end

  private

  def parse
    blocks = line.split(' ')
    self.cmd = blocks.shift

    self.options = blocks.map do |block|
      [block[0], block.include?('.') ? block[1..-1].to_f : block[1..-1].to_i]
    end.to_h
  end
end
