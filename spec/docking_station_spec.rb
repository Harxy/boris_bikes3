require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike}

  describe 'release_bike' do
    it 'raises an error when there are no bikes available' do
        expect { subject.release_bike }.to raise_error 'No bikes available'
      end

    it 'raises an error when there are no working bikes available' do
      bike = Bike.new
      bike.report_broken
      subject.dock bike
      expect { subject.release_bike }.to raise_error 'No working bikes available'
    end

    it 'does not raise an error when there are any working bikes available' do
      bike = Bike.new
      bike2 = Bike.new
      bike2.report_broken
      subject.dock bike
      subject.dock bike2
      expect { subject.release_bike }.not_to raise_error
    end

    it 'does not release more than one woring bike if many are available' do
      subject.capacity.times {subject.dock Bike.new}
      testArray = Array.new << subject.release_bike
      expect(testArray.length).to eq 1
    end

    # it releases only working bike when there are working bikes in the array
    #
    # ... and it deletes that working bike from the array

end
    describe 'dock' do
      it 'raises an error when full' do
        subject.capacity.times { subject.dock Bike.new }
        expect { subject.dock Bike.new }.to raise_error 'Docking station full'
      end
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'capacity=' do
    it 'should change the capacity when capacity is specified' do
      expect(subject.capacity=(30)).to eq subject.capacity
    end
  end

  it { is_expected.to respond_to(:capacity=).with(1).argument}

  it { is_expected.to respond_to(:dock).with(1).argument }

  it 'release working bikes' do
    subject.dock Bike.new
    bike = subject.release_bike
    expect(bike).to be_working

  end
end

#station = DockingStation.new
#bike = station.release_bike
#bike.working?

#station = DockingStation.new
#station.dock Bike.new
#bike = station.release_bike
#bike.working?
