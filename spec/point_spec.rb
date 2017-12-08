require_relative 'rails_helper'

describe Point do
  it 'should calculate distance' do
    expect(Point.new(0, 0).distance_to(Point.new(0, 1))).to eq 1.0
    expect(Point.new(0, 0).distance_to(Point.new(1, 0))).to eq 1.0
    expect(Point.new(0, 0).distance_to(Point.new(1, 1))).to eq 1.41
  end

  it 'from_vector' do
    expect(Point.from_vector(Vector[1, 2])).to eq Point.new(1, 2)
  end

  it 'to_vector' do
    expect(Point.new(3, 4).to_vector).to eq Vector[3, 4]
  end

  it 'subtraction' do
    expect(Point.new(1, 2)- Point.new(1, 3)).to eq Point.new(0, -1)
  end

  it 'round' do
    expect(Point.new(1.44444, 1.66666).round(2)).to eq Point.new(1.44, 1.67)
  end
end