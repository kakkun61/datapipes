require 'spec_helper'

describe Datapipes::Tube do
  describe 'composable' do
    let(:tube_a) do
      Class.new(Datapipes::Tube) do
        def run(data)
          data + 2
        end
      end.new
    end

    let(:tube_b) do
      Class.new(Datapipes::Tube) do
        def run(data)
          data * 3
        end
      end.new
    end

    let(:tube_c) do
      Class.new(Datapipes::Tube) do
        def run(data)
          data + 4
        end
      end.new
    end

    subject { tube_a >> tube_b >> tube_c }

    it 'composes' do
      expect(subject.run(4)).to eq 22
    end

    describe 'associative law' do
      let(:a) { (tube_a >> tube_b) >> tube_c }
      let(:b) { tube_a >> (tube_b >> tube_c) }

      it 'keeps' do
        expect(a.run(5)).to eq b.run(5)
      end
    end
  end
end
