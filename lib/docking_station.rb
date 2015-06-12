require_relative 'bike'
require_relative 'van'

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

  def release_bike broken = :working

    fail 'No bikes available' if empty?

    if broken == 'broken'
      bikes.each { |bike| return bikes.delete(bike) if bike.broken? }
      fail "No broken bikes available"
    else
      bikes.each { |bike| return bikes.delete(bike) if bike.working? }
      fail "No working bikes available"
    end
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
