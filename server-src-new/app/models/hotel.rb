class Hotel < ApplicationRecord
  has_many :dishes
  has_many :orders
  has_many :ratings

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, :address, :contact_number, :latitude, :longitude, :min_order,
            :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day,
            presence: true

  def self.filter_params(params)
    params[:hotel].permit(:name, :address, :avg_price_for_person, :min_order,
                          :is_closed_for_now, :contact_number, :is_verified,
                          :latitude, :longitude, :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
  end

  def self.search(params)
    query_string = params[:search]
    params[:hotel_page] ||= 1
    search_results = __elasticsearch__.search(
      query: {
        multi_match: {
          query: query_string,
          fields: ['name^5', 'address^3']
        }
      }
    )
    [search_results.paginate(page: params[:hotel_page], per_page: 25), { page: params[:hotel_page], total_pages: (search_results.results.total / 25).ceil }]
  end

  index_name 'hotels'
  document_type 'hotel'

  settings do
    mappings dynamic: false do
      indexes :name, type: :text
      indexes :address, type: :text, analyzer: :english
      indexes :latitude
      indexes :longitude
    end
  end
end
