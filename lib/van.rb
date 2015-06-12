require 'docking_station'

class Van

  def load(dockingstation)
    dockingstation.release_bike('broken')

  end

end
