# frozen_string_literal: true

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

    context 'when file is not named after a model' do
      it 'returns nil' do
        allow(File).to receive(:exists?).and_return(true)
        expect(update_from_file(file_name)).to be_nil
      end
    end

    context 'when file is names after a model' do
      let(:file_name) { 'people.csv' }

      context 'when values are brand new' do
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

        context 'when values are known to history' do
          let!(:person1) do
            create(:person, reference: '1', email: 'h.dupont@gmail.com', home_phone_number: '0123456789',
                   mobile_phone_number: '0623456789', firstname: 'Henri', lastname: 'Dupont', address: '10 Rue La bruyère')
          end
          let(:actual_attributes) { person1.attributes }
          let(:protected_columns) { get_protected_columns(person1.class.to_s.to_sym) }
          it 'does not update corresponding attributes' do
            person1.update(attributes_for(:person, reference: '1'))
            update_from_file(file_name)
            expect(Person.first).to have_attributes(actual_attributes.slice(*protected_columns))
          end
        end

        context 'when some values are not known to history' do
          let!(:person1) do
            create(:person, reference: '1', email: 'h.dupont@gmail.com', home_phone_number: '0123456789',
                   mobile_phone_number: '0623456789', firstname: 'Henri', lastname: 'Dupont', address: Faker::Address.street_address)
          end
          let(:actual_attributes) { person1.attributes }
          let(:protected_columns) { get_protected_columns(person1.class.to_s.to_sym) }
          it 'updates only attributes without history' do
            person1.update(attributes_for(:person, reference: '1'))
            update_from_file(file_name)
            expect(Person.first).to have_attributes(address: '10 Rue La bruyère')
          end
        end
    end
  end
end
