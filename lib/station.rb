class Station

  attr_reader :name, :zone

  def initialize(station_hash)
    @name = station_hash[:name]
    @zone = station_hash[:zone]
  end

# we replace these methods with attr_reader
  # def name
  #   @name
  # end
  #
  # def zone
  #   @zone
  # end

end
