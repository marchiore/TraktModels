//
//  ModelsTests.swift
//  movile-up-ios
//
//  Created by Marcelo Fabri on 16/04/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import XCTest
import TraktModels
import Argo
import Nimble

class ModelsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseIdentifiers() {
        let json: NSDictionary = [
            "trakt": 36440,
            "tvdb": 3254641,
            "imdb": "tt1480055",
            "tmdb": 63056,
            "tvrage": NSNull()
        ]
        
        let value = JSON.parse(json)
        let id = Identifiers.decode(value)
        
        expect(id.value).toNot(beNil())
        
        if let id = id.value {
            expect(id.trakt) == 36440
            expect(id.tvdb) == 3254641
            expect(id.imdb) == "tt1480055"
            expect(id.tmdb) == 63056
            expect(id.tvrage).to(beNil())
        }
    }
    
    func testParseImagesURLs() {
        let json: NSDictionary = [
            "full": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/original/529938d3cd.jpg?1409354198",
            "medium": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/medium/529938d3cd.jpg?1409354198",
            "thumb": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/thumb/529938d3cd.jpg?1409354198"
        ]
        
        let value = JSON.parse(json)
        let obj = ImagesURLs.decode(value).value
        
        expect(obj).toNot(beNil())
        
        if let obj = obj {
            expect(obj.fullImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/original/529938d3cd.jpg?1409354198"
            expect(obj.mediumImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/medium/529938d3cd.jpg?1409354198"
            expect(obj.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/thumb/529938d3cd.jpg?1409354198"
        }
    }
    
    func testParseEpisode() {
        let json: NSDictionary = [
            "season": 1,
            "number": 1,
            "title": "Winter Is Coming",
            "ids": [
                "trakt": 36440,
                "tvdb": 3254641,
                "imdb": "tt1480055",
                "tmdb": 63056,
                "tvrage": NSNull()
            ],
            "number_abs": NSNull(),
            "overview": "Ned Stark, Lord of Winterfell learns that his mentor, Jon Arryn, has died and that King Robert is on his way north to offer Ned Arryn’s position as the King’s Hand. Across the Narrow Sea in Pentos, Viserys Targaryen plans to wed his sister Daenerys to the nomadic Dothraki warrior leader, Khal Drogo to forge an alliance to take the throne.",
            "first_aired": "2011-04-18T01:00:00.000Z",
            "updated_at": "2014-08-29T23:16:39.000Z",
            "rating": 9,
            "votes": 111,
            "available_translations": [
            "en"
            ],
            "images": [
                "screenshot": [
                    "full": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/original/529938d3cd.jpg?1409354198",
                    "medium": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/medium/529938d3cd.jpg?1409354198",
                    "thumb": "https://walter.trakt.us/images/episodes/000/036/440/screenshots/thumb/529938d3cd.jpg?1409354198"
                ]
            ]
        ]
        
        let value = JSON.parse(json)
        let episode = Episode.decode(value).value
        
        expect(episode).toNot(beNil())
        
        if let episode = episode {
            expect(episode.seasonNumber) == 1
            expect(episode.number) == 1
            expect(episode.title) == "Winter Is Coming"
            expect(episode.identifiers?.trakt) == 36440
            expect(episode.identifiers?.tvdb) == 3254641
            expect(episode.identifiers?.imdb) == "tt1480055"
            expect(episode.identifiers?.tmdb) == 63056
            expect(episode.identifiers?.tvrage).to(beNil())
            expect(episode.overview) == "Ned Stark, Lord of Winterfell learns that his mentor, Jon Arryn, has died and that King Robert is on his way north to offer Ned Arryn’s position as the King’s Hand. Across the Narrow Sea in Pentos, Viserys Targaryen plans to wed his sister Daenerys to the nomadic Dothraki warrior leader, Khal Drogo to forge an alliance to take the throne."
            expect(episode.rating) == 9
            expect(episode.votes) == 111
            
            let components = NSDateComponents()
            components.year = 2011
            components.month = 4
            components.day = 18
            components.hour = 1
            components.timeZone = NSTimeZone(forSecondsFromGMT: 0)

            expect(episode.firstAired) == NSCalendar.currentCalendar().dateFromComponents(components)
            
            expect(episode.screenshot?.fullImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/original/529938d3cd.jpg?1409354198"
            expect(episode.screenshot?.mediumImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/medium/529938d3cd.jpg?1409354198"
            expect(episode.screenshot?.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/episodes/000/036/440/screenshots/thumb/529938d3cd.jpg?1409354198"
        }
    }

    func testParseShow() {
        let json: NSDictionary = [
            "title": "Sherlock",
            "year": 2010,
            "ids": [
                "trakt": 19792,
                "slug": "sherlock",
                "tvdb": 176941,
                "imdb": "tt1475582",
                "tmdb": 19885,
                "tvrage": 23433
            ],
            "overview": "Sherlock is a British television crime drama that presents a contemporary adaptation of Sir Arthur Conan Doyle's Sherlock Holmes detective stories. Created by Steven Moffat and Mark Gatiss, it stars Benedict Cumberbatch as Sherlock Holmes and Martin Freeman as Doctor John Watson.",
            "first_aired": "2010-07-25T19:30:00.000Z",
            "airs": [
                "day": "Sunday",
                "time": "20:30",
                "timezone": "Europe/London"
            ],
            "runtime": 90,
            "certification": "TV-14",
            "network": "BBC One",
            "country": "gb",
            "trailer": NSNull(),
            "homepage": NSNull(),
            "status": "returning series",
            "rating": 9.284190000000001,
            "votes": 18537,
            "updated_at": "2015-04-17T10:47:42.000Z",
            "language": "en",
            "available_translations": [
                "en",
                "ru",
                "zh",
                "hu",
                "pt",
                "es",
                "bg",
                "tr",
                "sk",
                "nl",
                "fr",
                "he",
                "ja",
                "de",
                "el",
                "it",
                "sv",
                "ko",
                "pl"
            ],
            "genres": [
                "drama"
            ],
            "aired_episodes": 9,
            "images": [
                "fanart": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/fanarts/original/ede801038d.jpg",
                    "medium": "https://walter.trakt.us/images/shows/000/019/792/fanarts/medium/ede801038d.jpg",
                    "thumb": "https://walter.trakt.us/images/shows/000/019/792/fanarts/thumb/ede801038d.jpg"
                ],
                "poster": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/posters/original/6311e0343c.jpg",
                    "medium": "https://walter.trakt.us/images/shows/000/019/792/posters/medium/6311e0343c.jpg",
                    "thumb": "https://walter.trakt.us/images/shows/000/019/792/posters/thumb/6311e0343c.jpg"
                ],
                "logo": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/logos/original/cf63398f03.png"
                ],
                "clearart": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/cleararts/original/0339c5f877.png"
                ],
                "banner": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/banners/original/ca665b6d1d.jpg"
                ],
                "thumb": [
                    "full": "https://walter.trakt.us/images/shows/000/019/792/thumbs/original/79e863da08.jpg"
                ]
            ]
        ]
        
        let value = JSON.parse(json)
        let show = Show.decode(value).value
        
        expect(show).toNot(beNil())
        
        if let show = show {
            expect(show.title) == "Sherlock"
            expect(show.year) == 2010
            
            expect(show.identifiers).toNot(beNil())
            expect(show.identifiers.trakt) == 19792
            expect(show.identifiers.slug) == "sherlock"
            expect(show.identifiers.tvdb) == 176941
            expect(show.identifiers.imdb) == "tt1475582"
            expect(show.identifiers.tmdb) == 19885
            expect(show.identifiers.tvrage) == 23433
            
            expect(show.overview) == "Sherlock is a British television crime drama that presents a contemporary adaptation of Sir Arthur Conan Doyle's Sherlock Holmes detective stories. Created by Steven Moffat and Mark Gatiss, it stars Benedict Cumberbatch as Sherlock Holmes and Martin Freeman as Doctor John Watson."
            
            let components = NSDateComponents()
            components.year = 2010
            components.month = 7
            components.day = 25
            components.hour = 19
            components.minute = 30
            components.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            
            expect(show.firstAired) == NSCalendar.currentCalendar().dateFromComponents(components)
            
            expect(show.runtime) == 90
            expect(show.network) == "BBC One"
            expect(show.country) == "gb"
            expect(show.trailerURL).to(beNil())
            expect(show.homepageURL).to(beNil())
            expect(show.status) == ShowStatus.Returning
            expect(show.rating) == 9.284190000000001
            expect(show.votes) == 18537
            
            expect(show.genres) == ["drama"]
            expect(show.airedEpisodes) == 9
            
            expect(show.fanart?.fullImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/fanarts/original/ede801038d.jpg"
            expect(show.fanart?.mediumImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/fanarts/medium/ede801038d.jpg"
            expect(show.fanart?.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/fanarts/thumb/ede801038d.jpg"
            
            expect(show.poster?.fullImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/posters/original/6311e0343c.jpg"
            expect(show.poster?.mediumImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/posters/medium/6311e0343c.jpg"
            expect(show.poster?.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/posters/thumb/6311e0343c.jpg"
            
            expect(show.logoImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/logos/original/cf63398f03.png"
            expect(show.clearArtImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/cleararts/original/0339c5f877.png"
            expect(show.bannerImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/banners/original/ca665b6d1d.jpg"
            expect(show.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/shows/000/019/792/thumbs/original/79e863da08.jpg"
        }
    }
    
    func testParseSeason() {
        let json: NSDictionary = [
            "number": 1,
            "ids": [
                "trakt": 3963,
                "tvdb": 364731,
                "tmdb": 3624,
                "tvrage": NSNull()
            ],
            "rating": 9.071429999999999,
            "votes": 294,
            "episode_count": 10,
            "aired_episodes": 9,
            "overview": "The first season of the epic fantasy television drama series Game of Thrones premiered on HBO on April 17, 2011, and concluded on June 19, 2011, airing on Sunday at 9:00 pm in the United States. It consisted of 10 episodes, each running approximately 55 minutes in length. Game of Thrones is based on the novel A Game of Thrones, the first entry in A Song of Ice and Fire series by George R. R. Martin. The story takes place in a fictional world, primarily upon a continent called Westeros. The noble House Stark, led by Lord Eddard \"Ned\" Stark is drawn into schemes against King Robert Baratheon when the Hand of the King Jon Arryn dies mysteriously.",
            "images": [
                "poster": [
                    "full": "https://walter.trakt.us/images/seasons/000/003/963/posters/original/3b1d09801b.jpg",
                    "medium": "https://walter.trakt.us/images/seasons/000/003/963/posters/medium/3b1d09801b.jpg",
                    "thumb": "https://walter.trakt.us/images/seasons/000/003/963/posters/thumb/3b1d09801b.jpg"
                ],
                "thumb": [
                    "full": "https://walter.trakt.us/images/seasons/000/003/963/thumbs/original/6c996deed7.jpg"
                ]
            ]
        ]
        
        let value = JSON.parse(json)
        let season = Season.decode(value).value
        
        expect(season).toNot(beNil())
        
        if let season = season {
            expect(season.number) == 1
            expect(season.identifiers).toNot(beNil())
            expect(season.identifiers?.trakt) == 3963
            expect(season.identifiers?.tvdb) == 364731
            expect(season.identifiers?.tmdb) == 3624
            expect(season.identifiers?.tvrage).to(beNil())
            
            expect(season.rating) == 9.071429999999999
            expect(season.votes) == 294
            expect(season.episodeCount) == 10
            expect(season.airedEpisodes) == 9
            expect(season.overview) == "The first season of the epic fantasy television drama series Game of Thrones premiered on HBO on April 17, 2011, and concluded on June 19, 2011, airing on Sunday at 9:00 pm in the United States. It consisted of 10 episodes, each running approximately 55 minutes in length. Game of Thrones is based on the novel A Game of Thrones, the first entry in A Song of Ice and Fire series by George R. R. Martin. The story takes place in a fictional world, primarily upon a continent called Westeros. The noble House Stark, led by Lord Eddard \"Ned\" Stark is drawn into schemes against King Robert Baratheon when the Hand of the King Jon Arryn dies mysteriously."
            
            expect(season.poster?.fullImageURL?.absoluteString) == "https://walter.trakt.us/images/seasons/000/003/963/posters/original/3b1d09801b.jpg"
            expect(season.poster?.mediumImageURL?.absoluteString) == "https://walter.trakt.us/images/seasons/000/003/963/posters/medium/3b1d09801b.jpg"
            expect(season.poster?.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/seasons/000/003/963/posters/thumb/3b1d09801b.jpg"
            
            expect(season.thumbImageURL?.absoluteString) == "https://walter.trakt.us/images/seasons/000/003/963/thumbs/original/6c996deed7.jpg"
        }
    }
}
