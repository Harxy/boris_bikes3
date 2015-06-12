require 'van'
require 'docking_station'

describe Van do
  it 'has a default capacity' do

  end

  it { is_expected.to respond_to(:load).with(1).argument }

  describe 'dockingstation interactions'
    it 'is able to call release_bike method on dockingstation' do
      station = DockingStation.new
      bikebroken = Bike.new
      bikebroken.report_broken
      station.dock bikebroken
      expect(subject.load(station).is_a?(Bike)).to eq true
    end


end
