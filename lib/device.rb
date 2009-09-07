class Device
  begin
    require 'hildon'
    @@platform = :hildon
  rescue Exception => e
    require 'gtk2'
    @@platform = :gtk2
  end

  def self.platform
    @@platform
  end

  def self.hildon?
    @@platform == :hildon
  end
end
