class Route < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable
  has_one_attached :gpx

  # validates :start_location, presence: true
  # validates :end_location, presence: true

  # before_save :lookup_locations

  private

  def lookup_locations
    self.start_latitude = Geocoder.search(start_location)[0].data['lat']
    self.start_longitude = Geocoder.search(start_location)[0].data['lon']
    self.end_latitude = Geocoder.search(end_location)[0].data['lat']
    self.end_longitude = Geocoder.search(end_location)[0].data['lon']
  end
end
