RSpec.describe Viking do
  before { allow_any_instance_of(Viking).to receive :puts }

  describe 'attributes' do
    it 'has a name' do
      name = 'Peter'
      expect(Viking.new(name)).to have_attributes name: name
    end

    it 'has health' do
      health_level = 109
      viking = Viking.new('N', health_level)

      expect(viking).to have_attributes health: health_level
      expect{ viking.health(110) }.to raise_error ArgumentError
    end

  end

  describe 'weapon' do
    let(:viking) { Viking.new }
    let(:bow)    { Bow.new }
    let(:axe)    { Axe.new }

    it 'it has a weapon slot--default weapon is nil' do
      expect(Viking.new).to have_attributes weapon: nil
    end

    it 'picks up a weapon' do
      viking.pick_up_weapon bow
      expect(viking.weapon).to be_kind_of Bow
    end

    it 'replaces weapons' do
      viking.pick_up_weapon bow

      viking.pick_up_weapon axe
      expect(viking.weapon).to be_kind_of Axe
    end

    it 'drops a weapon' do
      viking.pick_up_weapon bow

      viking.drop_weapon
      expect(viking.weapon).to be_nil
    end
  end

  describe 'receiving an attack' do
    let(:viking) { Viking.new }
    let(:damage) { 5 }
    it 'damages health' do
      expect { viking.receive_attack(damage) }
        .to change{ viking.health }.by -damage
    end
  end

  describe 'attacking another viking' do
    before { allow_any_instance_of(Bow).to receive :puts }
    before { allow_any_instance_of(Fists).to receive :puts }

    let(:winner) { Viking.new('Sven') }
    let(:loser)  { Viking.new('Jurgen') }

    it 'causes loser to take damage' do
      weapon = Bow.new
      winner.pick_up_weapon weapon
      expected_damage = winner.strength * weapon.use

      expect { winner.attack(loser) }.to change { loser.health }.by -expected_damage
    end

    context 'bow with no arrows' do
      it 'uses fists' do
        empty_bow = Bow.new(0)
        winner.pick_up_weapon empty_bow
        expected_damage = Fists.new.use * winner.strength

        expect { winner.attack(loser) }.to change { loser.health }.by -expected_damage
      end
    end

    context 'with no weapon' do
      it 'damages with fists' do
        fists = Fists.new
        expected_damage = fists.use * winner.strength

        expect { winner.attack(loser) }.to change { loser.health }.by -expected_damage
      end
    end

    context 'causes death' do
      it 'raises an erro' do
        not_quite_dead_yet = Viking.new('Porkins', 9)
        winner.pick_up_weapon(Bow.new)

        expect { winner.attack(not_quite_dead_yet) }
          .to raise_error.with_message 'Porkins has died...'
      end
    end
  end
end