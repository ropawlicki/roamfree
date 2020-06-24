require 'rails_helper'

RSpec.describe Note, type: :model do
  context "is not saved" do

    it "with blank city" do
      note = build(:note, city: "" )
      expect(note.save).to be false
    end

    it "with blank text" do
      note = build(:note, note_text: "" )
      expect(note.save).to be false
    end

    it "with text longer than 1000 characters" do
      note = build(:note, note_text: Faker::Lorem.characters(number: 1001) )
      expect(note.save).to be false
    end
  end
end
