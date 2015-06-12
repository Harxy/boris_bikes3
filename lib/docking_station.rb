require_relative 'bike'

class DockingStation

  DEFAULT_CAPACITY = 20
  attr_accessor :capacity

  def initialize capacity=DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity
  end

  def dock bike
    fail 'Docking station full' if full?
    bikes << bike
  end

  def release_bike
    fail 'No bikes available' if empty?
  #  if there is a bike which is working, pop it and then stop
    bikes.each do |bike|
      if bike.working?
        return bikes.delete(bike) #do something
      else
        fail "No working bikes available"
      end
    end

    # fail 'No working bikes available' if bikes.last.broken?
    # bikes.pop
  end

  private
  
  attr_reader :bikes

  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end

end
