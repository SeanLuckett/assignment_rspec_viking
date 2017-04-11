RSpec.describe Bow do
  context 'default bow' do
    it 'starts with 10 arrows' do
      expect(Bow.new.arrows).to eq 10
    end
  end

  context 'bow with 13 arrows' do
    it 'starts with 13 arrows' do
      expect(Bow.new(13).arrows).to eq 13
    end
  end

  describe '#use' do
    before { allow_any_instance_of(Bow).to receive :puts }

    it 'uses an arrow' do
      bow = Bow.new
      expect { bow.use }.to change{ bow.arrows }.by -1
    end

    context 'no arrows left' do
      let(:empty_bow) { Bow.new(0) }

      it 'throws an error' do
        expect { empty_bow.use }.to raise_error.with_message 'Out of arrows'
      end
    end
  end
end