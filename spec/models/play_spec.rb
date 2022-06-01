# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Play do
  let(:game) { create :game, :with_levels }
  let(:team) { create :team }

  describe '#current_level' do
    context 'when a play is created' do
      let!(:play) { Play.create! game:, team: }

      it 'automatically sets to the first level of the game' do
        expect(play.current_level).to eq game.levels.first
      end
    end
  end

  describe '#advance_current_level!' do
    let(:play) { create :play, game: }

    context 'when the play is on any but the last level' do
      it 'changes current level of play to the next one' do
        expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.second)
        expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.third)
      end
    end

    context 'when the play is on the last level' do
      before { play.update current_level: game.last_level }

      it 'marks the play as finished' do
        play.advance_current_level!

        expect(play).to be_finished
      end

      it 'saves the finish time' do
        Timecop.freeze do
          expect { play.advance_current_level! }
            .to change(play, :finished_at).from(nil).to(Time.current)
        end
      end
    end
  end

  describe '#next_level' do
    let(:play) { create :play, game: }

    subject { play.next_level }

    context 'when current level is the first one' do
      it { is_expected.to eq game.levels.second }

      context 'when current level is the second one' do
        before { play.advance_current_level! }

        it { is_expected.to eq game.levels.third }
      end
    end
  end

  describe '#reached_current_level_at' do
    subject { play.reached_current_level_at }

    before { Timecop.freeze }

    after { Timecop.return }

    context 'when play is created' do
      let!(:play) { Play.create! game:, team: }

      it { is_expected.to eq Time.current }

      context 'when play is advanced to the next level' do
        before { Timecop.freeze(10.minutes.from_now) }

        it 'gets updated to current time' do
          expect { play.advance_current_level! }.to change(play, :reached_current_level_at).to(Time.current)
        end
      end
    end
  end

  describe '#finished?' do
    let(:play) { Play.create! game:, team:, finished_at: }

    subject { play.finished? }

    context 'when finished_at is nil' do
      let(:finished_at) { nil }

      it { is_expected.to be false }
    end

    context 'when finished_at is non-nil' do
      let(:finished_at) { 1.minute.ago }

      it { is_expected.to be true }
    end
  end
end
