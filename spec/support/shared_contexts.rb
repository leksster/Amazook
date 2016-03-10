shared_context 'http success' do
  it 'returns http success' do
    expect(response).to have_http_status(:success)
  end
end