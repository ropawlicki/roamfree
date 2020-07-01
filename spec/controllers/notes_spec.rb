require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  describe "POST #create" do
    let(:user) { build(:user) }

    before(:each) do
      allow(controller).to receive(:current_user) { user }
    end

    context "with valid attributes" do
      let(:valid_attr) { { city: "Warsaw", note_text: "It was beautiful!" } }

      it "creates note" do
        post :create, params: valid_attr, as: :json
        expect(Note.count).to eq(1)
      end
    end

    context "with blank attributes" do
      let(:valid_attr) { { city: "", note_text: "" } }

      it "doesn't create note" do
        post :create, params: valid_attr, as: :json
        expect(Note.count).to eq(0)
      end
    end
  end

  describe "DELETE #delete" do

    context "is inaccessible" do
      before(:each) do
        @owner = build(:user)
        @note = build(:note)
        @owner.notes << @note
        @owner.save
      end

      it "to other signed in users" do
        stranger = create(:user2)
        allow(controller).to receive(:current_user) { stranger }
        delete :delete, params: { id: @note.id.to_s }, as: :json
        expect(Note.count).to eq(1)
      end

      it "to unsigned users" do
        delete :delete, params: { id: @note.id.to_s }, as: :json
        expect(Note.count).to eq(1)
      end
    end
  end
end