# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
# Movie.create(title: "Mad Max: Fury Road", overview: "In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search of her homeland with the help of a group of female prisoners, a psychotic worshiper, and a drifter named Max.", poster_url: "https://image.tmdb.org/t/p/original/kqjL17yufvn9OVLyXYpvtyrFfak.jpg", rating: 8.3)
# Movie.create(title: "Inception", overview: "A thief who enters the dreams of others to steal secrets from their subconscious is offered a chance to have his criminal history erased as payment for the implantation of another person's idea into a target's subconscious.", poster_url: "https://image.tmdb.org/t/p/original/s2bT29y0ngXxxu2IA8AOzzXTRhd.jpg", rating: 8.8)
# Movie.create(title: "Kill Bill: Vol. 1", overview: "After awakening from a four-year coma, a former assassin wreaks vengeance on the team of assassins who betrayed her.", poster_url: "https://image.tmdb.org/t/p/original/v7TaX8kXMXs5yFFGR41guUDNcnB.jpg", rating: 8.1)
# Movie.create(title: "The Italian Job", overview: "After being betrayed and left for dead in Italy, Charlie Croker and his team plan an elaborate gold heist against their former ally.", poster_url: "https://image.tmdb.org/t/p/original/6peNVA2HRJGzBt66CkDkKVAu3vT.jpg", rating: 7.1)
# Movie.create(title: "Harry Potter and the Sorcerer's Stone", overview: "Rescued from the outrageous neglect of his aunt and uncle, a young boy with a great destiny proves his worth while attending Hogwarts School of Witchcraft and Wizardry.", poster_url: "https://image.tmdb.org/t/p/original/dCtFvscYcXQKTNvyyaQr2g2UacJ.jpg", rating: 7.9)
# Movie.create(title: "Harry Potter and the Chamber of Secrets", overview: "An ancient prophecy seems to be coming true when a mysterious presence begins stalking the corridors of a school of magic and leaving its victims paralyzed.", poster_url: "https://image.tmdb.org/t/p/original/sdEOH0992YZ0QSxgXNIGLq1ToUi.jpg", rating: 7.7)
# Movie.create(title: "Harry Potter and the Prisoner of Azkaban", overview: "Harry Potter, Ron and Hermione return to Hogwarts School of Witchcraft and Wizardry for their third year of study, where they delve into the mystery surrounding an escaped prisoner who poses a dangerous threat to the young wizard.", poster_url: "https://image.tmdb.org/t/p/original/jUFjMoLh8T2CWzHUSjKCojI5SHu.jpg", rating: 7.9)
# Movie.create(title: "Harry Potter and the Goblet of Fire", overview: "Harry Potter finds himself competing in a hazardous tournament between rival schools of magic, but he is distracted by recurring nightmares.", poster_url: "https://image.tmdb.org/t/p/original/6sASqcdrEHXxUhA3nFpjrRecPD2.jpg", rating: 7.9)
# Movie.create(title: "Harry Potter and the Order of the Phoenix", overview: "With their warning about Lord Voldemort's return scoffed at, Harry and Dumbledore are targeted by the Wizard authorities as an authoritarian bureaucrat slowly seizes power at Hogwarts.", poster_url: "https://image.tmdb.org/t/p/original/4YnLxYLHhT4UQ8i9jxAXWy46Xuw.jpg", rating: 7.7)
# Movie.create(title: "Harry Potter and the Half-Blood Prince", overview: "As Harry Potter begins his sixth year at Hogwarts, he discovers an old book marked as 'the property of the Half-Blood Prince' and begins to learn more about Lord Voldemort's dark past.", poster_url: "https://image.tmdb.org/t/p/original/bFXys2nhALwDvpkF3dP3Vvdfn8b.jpg", rating: 7.7)
# Movie.create(title: "Harry Potter and the Deathly Hallows: Part 1", overview: "As Harry races against time and evil to destroy the Horcruxes, he uncovers the existence of three most powerful objects in the wizarding world: the Deathly Hallows.", poster_url: "https://image.tmdb.org/t/p/original/YJ8wvfuUf5IUqk3mpb3OWgRB6lE.jpg", rating: 7.8)
# Movie.create(title: "Harry Potter and the Deathly Hallows: Part 2", overview: "Harry, Ron, and Hermione search for Voldemort's remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.", poster_url: "https://image.tmdb.org/t/p/original/fTplI1NCSuEDP4ITLcTps739fcC.jpg", rating: 8.1)
require 'httparty'
puts "Deleting all movies and related bookmarks"
Bookmark.destroy_all
Movie.destroy_all
puts "Making new"
response = HTTParty.get('https://tmdb.lewagon.com/movie/top_rated')
response.parsed_response
movies_hashes = response['results']
movies_hashes.each do |movie|
  Movie.create!({
    title: movie['original_title'],
    overview: movie['overview'],
    rating: movie ['vote_average'],
    poster_url: "https://image.tmdb.org/t/p/original/#{movie["poster_path"]}"
  })
end
