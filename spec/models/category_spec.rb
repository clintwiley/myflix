require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

describe "#recent_videos" do
  it 'returns the videos in the reverse chronological order by created at' do
    comedies = Category.create(title: "comedies")
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
    south_park = Video.create(title: "South Park", description: "funny show", category: comedies)
    expect(comedies.recent_videos).to eq([south_park, futurama])
end
  it 'returns all of the videos if there are less than 6' do
    comedies = Category.create(title: "comedies")
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
    south_park = Video.create(title: "South Park", description: "funny show", category: comedies)
    expect(comedies.recent_videos.count).to eq(2)
  end
  it 'returns 6 videos if there are more that 6 videos' do
    comedies = Category.create(title: "comedies")
    7.times {Video.create(title: "South Park", description: "funny show", category: comedies)}
    expect(comedies.recent_videos.count).to eq(6)
  end
  it 'returns the most recent 6 videos' do
    comedies = Category.create(title: "comedies")
    6.times {Video.create(title: "South Park", description: "funny show", category: comedies)}
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
    expect(comedies.recent_videos).not_to include(futurama)
  end
  it 'returns an empty array if the category does not have any videos' do
    comedies = Category.create(title: "comedies")
    expect(comedies.recent_videos).to eq([])
  end
  end
end