class Units

  def self.cm_to_ft (centimeters)
    return (centimeters * 0.3937) / 12
  end
  def self.cm_to_ft_str (centimeters)
    return self.cm_to_ft(centimeters).to_s + ' ft'
  end

end