module AddUniqId
  # included ActiveSupport/Concern
  def add_uniq_id
    self.uniq_id = SecureRandom.hex
  end
end
