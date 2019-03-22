FactoryBot.define do
  factory :setlist_item do
    setlist { Setlist.random }
    type { rand(SetlistItem.types.length) }
    is_cover { rand(2).zero? }

    info do
      next if SetlistItem.types[:set] == type || rand(2).zero?

      Faker::Lorem.sentence
    end

    track do
      next if SetlistItem.types[:set] == type || rand(2).zero?

      artist = is_cover ? Artist.where.not(id: setlist.artist.id).random : setlist.artist
      artist.tracks.random
    end

    featuring_artist do
      next if SetlistItem.types[:track] != type || rand(2).zero?

      Artist.where.not(id: setlist.artist.id).random
    end
  end
end
