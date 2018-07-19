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

# making the net
root_shift = {'X' => 0, 'Y' => 2}

net_shift = {'X' => (240 / 2), 'Y' => (180 / 2)}
net_coder = GcodeRepeater.new
net_coder.f_in =  '/Users/bguban/Dropbox/projects/ohoronka/Sides/net.nc'
net_coder.f_out = '/Users/bguban/Dropbox/projects/ohoronka/Sides/net_moved.nc'
net_coder.shifts = [GcodeRepeater.sum_shifts(root_shift, net_shift)]

net_coder.run

# moving the side with a button
movement_shift = {'X' => 0, 'Y' => 26}
# GcodeRepeater.cut_garbage_lines('/Users/bguban/Dropbox/projects/ohoronka/Sides/with_button.nc')
mover = GcodeRepeater.new
mover.f_in = '/Users/bguban/Dropbox/projects/ohoronka/Sides/with_button.nc'
mover.f_out = '/Users/bguban/Dropbox/projects/ohoronka/Sides/with_button_moved.nc'
mover.shifts = [GcodeRepeater.sum_shifts(root_shift, movement_shift)]
mover.run

# preparing the side without the button
# GcodeRepeater.cut_garbage_lines('/Users/bguban/Dropbox/projects/ohoronka/Sides/without_button.nc')

# making the couple of the two sides
GcodeRepeater.compound(
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/without_button.nc',
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/with_button_moved.nc',
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/two_sides.nc'
)

# repeating the couple by the net
net_repeater = GcodeRepeater.new
net_repeater.f_in = '/Users/bguban/Dropbox/projects/ohoronka/Sides/two_sides.nc'
net_repeater.f_out = '/Users/bguban/Dropbox/projects/ohoronka/Sides/sides_by_the_net.nc'
net_repeater.build_matrix(4, 3, 58, 29 * 2)
# net_repeater.shifts.delete_at(0)
net_repeater.run

# shift the sides by the root
all_mover = GcodeRepeater.new
all_mover.f_in = '/Users/bguban/Dropbox/projects/ohoronka/Sides/sides_by_the_net.nc'
all_mover.f_out = '/Users/bguban/Dropbox/projects/ohoronka/Sides/all_ready.nc'
all_mover.shifts = [GcodeRepeater.sum_shifts(root_shift, {'X' => 33, 'Y' => 17.5})]
all_mover.run

# check with the net
GcodeRepeater.compound(
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/all_ready.nc',
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/net_moved.nc',
  '/Users/bguban/Dropbox/projects/ohoronka/Sides/net_checker.nc'
)

class GcodeRepeater
  attr_accessor :f_in, :f_out, :shifts, :pre, :post

  def self.compound(*files, result)
    File.open(result, 'w') do |res|
      files.each do |file|
        File.foreach(file) do |line|
          res.puts line
        end
      end
    end
  end
  #
  # def self.cut_garbage_lines(file, start = 1, ending = 1)
  #   lines = File.readlines(file)
  #   File.open(file, 'w') do |f|
  #     lines[start..(-ending - 1)].each do |line|
  #       f.puts line
  #     end
  #   end
  # end

  def self.sum_shifts(a, b)
    res = {}
    res['X'] = a['X'] + b['X']
    res['Y'] = a['Y'] + b['Y']
    res
  end

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
