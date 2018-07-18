describe 'Signup controller', type: 'request' do
  before(:each) do
    @email = "#{Time.now.to_f}gokulprabhu@gmail.com"
    @password = 'Demo@123'
    @address = '42 , Silamba mudhaliyar street'
  end

  it 'singup user' do

    post '/signup', params: { email: @email, password: @password, password_confirmation: @password }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(json_body['errors']['address'][0]).to eql("can't be blank")


    post '/signup', params: { password: @password, password_confirmation: @password, address: @address }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(json_body['errors']['email'][0]).to eql("can't be blank")

    post '/signup', params: { email: @email, password: @password, password_confirmation: @password, address: @address }
    expect(response).to have_http_status(:ok)
  end

  it 'login user' do

    post '/signup', params: { email: @email, password: @password, password_confirmation: @password, address: @address }
    expect(response).to have_http_status(:ok)

    post '/login', params: { email: @email, password: @password }
    expect(response).to have_http_status(:ok)

    post '/login', params: { email: @email, password: 'Dummy' }
    expect(response).to have_http_status(:unauthorized)
  end
end
