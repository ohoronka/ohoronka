require 'rails_helper'
require Rails.root + 'support/gcode_repeater'

RSpec.describe 'GcodeRepeater' do
  it 'parses the line' do
    line = 'G01 Y-5.000 Z-1.000 F1000 S2000'
    cmd = Command.new(line)
    expect(cmd.cmd).to eq('G01')
    expect(cmd.options).to match({
      'Y' => -5.0,
      'Z' => -1.0,
      'F' => 1000,
      'S' => 2000
    })

    # shift the line
    cmd.shift({'X' => 10.0, 'Y' => 10.0})
    expect(cmd.options).to match({
      'Y' => 5.0,
      'Z' => -1.0,
      'F' => 1000,
      'S' => 2000
    })

    # to_s
    expect(cmd.to_s).to eq('G01 Y5.000 Z-1.000 F1000 S2000')
  end
end
