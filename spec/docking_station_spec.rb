require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike}

  describe 'release_bike' do
    it 'raises an error when there are no bikes available' do
        expect { subject.release_bike }.to raise_error 'No bikes available'
      end

    it 'raises an error when there are no working bikes available' do
      bike = double :bike, :broken? => true, :working? => false
      subject.dock bike
      expect { subject.release_bike }.to raise_error 'No working bikes available'
    end

    it 'does not raise an error when there are any working bikes available' do

      subject.dock double :bikebroken, :broken? => true, :working? => false
      subject.dock double :bikeworking, :broken? => false, :working? => true
      expect { subject.release_bike }.not_to raise_error
    end

    it 'does not release more than one working bike if many are available' do
      subject.capacity.times {subject.dock double :bike, :working? => true}
      testArray = Array.new << subject.release_bike
      expect(testArray.length).to eq 1
    end

  describe 'van interactions' do

    it { is_expected.to respond_to(:release_bike).with(1).argument }

    it 'should return a bike if passed "broken" parameter' do

      subject.dock double :bike, :broken? => true, :working? => false, :is_a? => true
      expect(subject.release_bike('broken').is_a?(Bike)).to eq true

    end
    it 'should return a broken bike if passed "broken" parameter' do
      subject.dock double :bike, :broken? => true, :working? => false
      expect(subject.release_bike('broken').working?).to eq false
    end
  end

    # it releases only working bike when there are working bikes in the array
    #
    # ... and it deletes that working bike from the array

end
    describe 'dock' do
      it 'raises an error when full' do
        subject.capacity.times { subject.dock double :bike }
        expect { subject.dock double :bike }.to raise_error 'Docking station full'
      end
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'capacity setter method' do
    it 'should change the capacity when capacity is specified' do
      expect(subject.capacity=(30)).to eq subject.capacity
    end
  end

  it { is_expected.to respond_to(:capacity=).with(1).argument}

  it { is_expected.to respond_to(:dock).with(1).argument }

  it_behaves_like BikeContainer
end
