require_relative '../../app/services/data_import'

RSpec.describe DataImport do
  include DataImport

  let(:file_name) { "#{Faker::Verb.base}.csv" }

  describe '#update_from_file' do
    context 'with a non existent file' do
      it 'returns nil' do
        expect(update_from_file(file_name)).to be_nil
      end
    end

    context 'with a file not named after a model' do
      it 'returns nil' do
        allow(File).to receive(:exists?).and_return(true)
        expect(update_from_file(file_name)).to be_nil
      end
    end

    context 'with a file name written as a model name' do
      let(:file_name) { "people.csv" }
      let!(:person1) { create(:person, reference: '1') }

      it 'updates the record found' do
        update_from_file(file_name)
        expect(Person.first.reload).to have_attributes(firstname: 'Henri')
      end

      it "creates records that does'nt exist yet" do
        update_from_file(file_name)
        expect(Person.count).to eq(2)
      end
    end
  end
end
