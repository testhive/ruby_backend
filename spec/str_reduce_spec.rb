def reduce_str input, limit
  if limit==0
    ""
  else
    result = String.new
    current_char = input.chars.first
    count = 0
    input.chars.each do |char|
      if count < limit && char == current_char
        count += 1
        result += char
      elsif count == limit && char == current_char
        next
      elsif char != current_char
        current_char = char
        count = 1
        result += char
      end
    end
    result
  end
end

RSpec.describe reduce_str "", 0 do
  context 'When testing reduce string' do
    it 'should return an empty string when limit is 0' do
      result = reduce_str "aassccsdfgsdfg", 0
      expect(result).to eq ""
    end
    it 'should reduce correctly with single char type' do
      result = reduce_str "aaaaa", 2
      expect(result).to eq "aa"
    end
    it 'should reduce correctly with multiple char types' do
      result = reduce_str "aaaaaabbbbbbnnnnnn", 3
      expect(result).to eq "aaabbbnnn"
    end
    it 'should not touch char counts below limit' do
      result = reduce_str "aaaaabbcccccc", 4
      expect(result).to eq "aaaabbcccc"
    end
  end
end