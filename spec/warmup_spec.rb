RSpec.describe Warmup do
  let(:warmup) { Warmup.new }
  before do
    allow(warmup).to receive(:gets) { "string\n" }
    allow(warmup).to receive(:puts)
  end

  describe '#gets_shout' do
    it 'capitalizes every character in input' do
      expect(warmup.gets_shout).to eq 'STRING'
    end
  end

  describe '#triple_size' do
    context 'given: an array of size n' do
      it 'returns array of size 3n' do
        arr = double('Array', size: 3)
        expect(warmup.triple_size(arr)).to eq 9
      end
    end
  end

  describe '#calls_some_methods' do
    context 'given: a string' do
      let(:test_string) { double('fascinating', empty?: false) }
      before do
        allow(test_string).to receive :upcase!
        allow(test_string).to receive :reverse!
      end

      it 'has #upcase! called' do
        warmup.calls_some_methods(test_string)
        expect(test_string).to have_received :upcase!
      end

      it 'has #reverse called' do
        warmup.calls_some_methods(test_string)
        expect(test_string).to have_received :reverse!
      end

      it 'does not change original object' do
        expect(warmup.calls_some_methods(test_string)).to_not equal test_string
      end
    end
  end
end