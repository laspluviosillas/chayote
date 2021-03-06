class Task
  include Mongoid::Document
  include Mongoid::Timestamps  
  referenced_in :user
  referenced_in :project
  references_many :time_entries, :dependent => :destroy
  field :name
  
  validates_presence_of :name

  def most_recent_entry_date
      entry = time_entries.desc(:date).first
      (entry) ? entry.date : nil
  end
  def hours
    total_hours = 0
    time_entries.collect { |entry| total_hours += entry.hours }
    total_hours
  end
  def total_hours_for_dates(start_date, end_date)
    total_hours = 0
    time_entries.where(:date.gte => start_date, :date.lte => end_date).collect { |entry| total_hours += entry.hours }
    total_hours
  end
end
