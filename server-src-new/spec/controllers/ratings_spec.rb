describe 'Ratings helper' , type: 'request' do

  it 'making a request without token ' do
    post '/ratings'
    expect(response.status).to eql(401)
  end
end