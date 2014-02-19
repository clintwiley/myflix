require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description )}
end

describe 'search_by_title' do
  it 'returns an empty array if there is no match' do
    futurama = Video.create(title: 'Futurama', description: 'Funny show')
    back_to_future = Video.create(title: 'Back to Future', description: 'A time travel movie.')
    expect(Video.search_by_title('hello')).to eq([])
  end
  it 'returns an array of one video for an exact match' do
    futurama = Video.create(title: 'Futurama', description: 'Funny show')
    back_to_future = Video.create(title: 'Back to Future', description: 'A time travel movie.')
    expect(Video.search_by_title('Futurama')).to eq([futurama])
  end
  it "returns an array of one video for partial match" do
    futurama = Video.create(title: 'Futurama', description: 'Funny show')
    back_to_future = Video.create(title: 'Back to Future', description: 'A time travel movie.')
    expect(Video.search_by_title("rama")).to eq([futurama])
  end
  it "returns an array of videos for partial matches by created_at" do
    futurama = Video.create(title: 'Futurama', description: 'Funny show')
    back_to_future = Video.create(title: 'Back to Future', description: 'A time travel movie.', created_at: 1.day.ago)
    expect(Video.search_by_title("futu")).to eq([futurama, back_to_future])
  end
  it "returns an empty array for empty search term" do
    expect(Video.search_by_title("")).to eq([])
  end
end




