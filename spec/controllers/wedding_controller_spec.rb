require 'spec_helper'
require 'wedding/wedding_controller'
include Wedding

describe WeddingController do
  context 'with render_views' do
    render_views

    describe 'GET /wedding' do
      it 'renders homepage in French by default' do
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Retenez votre 28 juin 2014/m
      end

      it 'renders homepage in French if provided with an incompatible locale' do
        request.headers['Accept-Language'] = 'de'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Retenez votre 28 juin 2014/m
      end

      it 'renders homepage in French if fr is provided' do
        request.headers['Accept-Language'] = 'fr'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Retenez votre 28 juin 2014/m
      end

      it 'renders homepage in French if fr-FR,fr;q=0.8 is provided' do
        request.headers['Accept-Language'] = 'fr-FR,fr;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Retenez votre 28 juin 2014/m
      end

      it 'renders homepage in English if en-US,en;q=0.8 is provided' do
        request.headers['Accept-Language'] = 'en-US,en;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end

      it 'renders homepage in English if en-GR,en;q=0.8 is provided' do
        request.headers['Accept-Language'] = 'en-GR,en;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end

      it 'renders homepage in English if en-US;q=0.8 is provided' do
        request.headers['Accept-Language'] = 'en-US;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end

      it 'renders homepage in English if en-GR;q=0.8 is provided' do
        request.headers['Accept-Language'] = 'en-GR;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end

      it 'renders homepage in English if en is provided' do
        request.headers['Accept-Language'] = 'en'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end

      it 'renders homepage in English when provided with en as a parameter, and persists this value for later requests' do
        get :home, {locale: :en}
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m

        request.headers['Accept-Language'] = 'fr-FR,fr;q=0.8'
        get :home
        expect(response).to render_template('wedding/home')
        expect(response.body).to match /Save the date: June 28th, 2014/m
      end
    end
  end 
end