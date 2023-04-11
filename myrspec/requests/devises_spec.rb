require 'rails_helper'

RSpec.describe "Devises", type: :request do
  describe "GET /devises" do
    it "works! (now write some real specs)" do
      get devises_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Devise routes' do
    it 'routes to confirmations controller' do
      expect(get: '/users/confirmation').to route_to(controller: 'users/confirmations', action: 'show')
    end

    it 'routes to sessions controller' do
      expect(get: '/users/sign_in').to route_to(controller: 'devise/sessions', action: 'new')
    end

    it 'routes to registrations controller' do
      expect(get: '/users/sign_up').to route_to(controller: 'devise/registrations', action: 'new')
    end
  end
end
