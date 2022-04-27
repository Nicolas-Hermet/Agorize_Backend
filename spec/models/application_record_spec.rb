RSpec.describe ApplicationRecord do
  describe 'Callbacks' do
    describe 'before_update' do
      describe '#record_history' do
        context 'when model is History' do
          let!(:history) { create(:history) }

          it 'updates the model' do
            expect { history.update(attributes_for(:history)) }.not_to change(History, :count)
          end
        end

        %i[building person].each do |model|

          let!(:instance) { create(model) }
          let!(:new_attributes) { attributes_for(model) }
          let!(:number_of_changed_attributes) { new_attributes.size }

          context "when model is #{model.capitalize}" do

            context 'when data has been changed' do
              it 'updates the record' do
                instance.update(new_attributes)
                expect(instance.reload).to have_attributes(new_attributes)
              end

              it 'saves the previous values in the History table' do
                expect { instance.update(new_attributes) }.to change(History, :count).from(0).to(number_of_changed_attributes + 1)
                expect(History.last.reload).to have_attributes({ memorable_type: instance.class.to_s })
              end
            end

            context 'when data has not been changed' do
              let(:not_so_new_attributes) { instance.attributes }

              it 'updates the record but does not save history' do
                expect { instance.update(not_so_new_attributes) }.not_to change(History, :count)
              end
            end
          end
        end
      end
    end
  end
end
