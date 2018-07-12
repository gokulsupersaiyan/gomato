class Dish < ApplicationRecord
  belongs_to :hotel


  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :dish_name, :description, :picture_url, :price, :dish_type, presence: true
  validates_numericality_of :price, greater_than: 0

  def self.filter_params(params)
    params[:dish].permit(:dish_name, :description, :picture_url, :hotel_id, :dish_type, :price)
  end

  def self.search(params)
    query_string = params[:search]
    params[:dish_page] ||= 1
    search_results = __elasticsearch__.search(
        query: {
            multi_match: {
                query: query_string,
                fields: ['dish_name^5', 'description^3']
            }
        }
    )
    [search_results.paginate(page: params[:dish_page], per_page: 25), { page: params[:dish_page], total_pages: (search_results.results.total / 25).ceil }]
  end

  index_name 'dishes'
  document_type 'dish'

  settings do
    mappings dynamic: false do
      indexes :dish_name, type: :text
      indexes :description, type: :text, analyzer: :english
    end
  end

end
