require 'ostruct'

describe SpinDoctor do
  context 'get_next_item' do
    before do
      @list = (0..5).map { |i| OpenStruct.new(:id => i) }
    end

    it 'should return the next item in the list except for the last item' do
      @list.reject{|i| i == @list.last}.each_with_index do |item, index|
        val = SpinDoctor.get_next_item(@list, item)
        expect(val).to eq(@list[index+1])
      end
    end

    it 'should return the first item if the last from the list is passed in' do
      val = SpinDoctor.get_next_item(@list, @list.last)
      expect(val).to eq(@list.first)
    end

    it 'should return a random item from the list if the last item is not in the list' do
      expect(@list).to receive(:sample)
      SpinDoctor.get_next_item(@list, OpenStruct.new(:id => :not_found))
    end

    it 'should return a random item from the list if the last item is nil' do
      expect(@list).to receive(:sample)
      SpinDoctor.get_next_item(@list, nil)
    end
  end
end

