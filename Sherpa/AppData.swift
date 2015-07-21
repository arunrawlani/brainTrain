//
//  DataExplore.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/18/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import Foundation

class DataExplore {
    class Entry {
        let imagename: String
        let heading: String
        init(fname: String,heading: String){
            self.imagename = fname
            self.heading = heading
        }
    }
    let places = [
        Entry(fname: "NewYork", heading: "New York City"),
        Entry(fname: "LasVegas", heading: "Las Vegas"),
        Entry(fname: "LosAngeles", heading: "Los Angeles")
    ]
}

class DataTours {
    class TourEntry {
        let bgImage: String
        let tourName: String
        let languages: String
        let cost: String
        let circularImage: String
        let cityImage: String
        init(bgImage: String, tourName: String, languages: String, cost: String, circularImage: String, cityImage: String){
            self.bgImage = bgImage
            self.tourName = tourName
            self.languages = languages
            self.cost = cost
            self.circularImage = circularImage
            self.cityImage = cityImage
        }
    }
    
    let toursNY = [
        TourEntry(bgImage: "tourEntryBG", tourName: "Central Park", languages: "English, French", cost: "$24", circularImage: "DisplayPicture", cityImage: "NewYork"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Statue of Liberty", languages: "German, French", cost: "$42", circularImage: "DisplayPicture", cityImage: "NewYork"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Upper East Side", languages: "Mandarin, Hindi", cost: "$99", circularImage: "DisplayPicture", cityImage: "NewYork"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Manhattan", languages: "Spanish, Russian", cost: "$12", circularImage: "DisplayPicture", cityImage: "NewYork")
    ]
    let toursVegas = [
        TourEntry(bgImage: "tourEntryBG", tourName: "Bellagio Resort", languages: "Mandarin, Hindi", cost: "$15", circularImage: "DisplayPicture", cityImage: "LasVegas"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Vegas Night Club", languages: "Japanese, Korean", cost: "$78", circularImage: "DisplayPicture", cityImage: "LasVegas"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Mandalay Bay", languages: "Greek, English", cost: "$32", circularImage: "DisplayPicture", cityImage: "LasVegas"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Stratosphere Tower", languages: "Hebrew, Dutch", cost: "$98", circularImage: "DisplayPicture", cityImage: "LasVegas")
    ]
    let toursLA = [
        TourEntry(bgImage: "tourEntryBG", tourName: "Venice Beach", languages: "Mandarin, Hindi", cost: "$10", circularImage: "DisplayPicture", cityImage: "LosAngeles"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Downtown", languages: "English, German", cost: "$24", circularImage: "DisplayPicture", cityImage: "LosAngeles"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Hollywood", languages: "Spanish, Hindi", cost: "$95", circularImage: "DisplayPicture", cityImage: "LosAngeles"),
        TourEntry(bgImage: "tourEntryBG", tourName: "Santa Monica", languages: "Spanish, Italian", cost: "$40", circularImage: "DisplayPicture", cityImage: "LosAngeles")
    ]
}

class DataDashBoard {
    class ScheduledEntry {
        let tourTime: String
        let tourTimeAmorPM: String
        let tourName: String
        let tourDate: String
        let tourGuide: String
        
        init(tourTime: String, tourTimeAmorPM: String, tourName: String, tourDate: String, tourGuide: String){
            self.tourName = tourName
            self.tourTime = tourTime
            self.tourTimeAmorPM = tourTimeAmorPM
            self.tourDate = tourDate
            self.tourGuide = tourGuide
        }
    }
    
    let scheduledTours = [
        ScheduledEntry(tourTime: "10", tourTimeAmorPM: "AM", tourName: "Lake Tahoe", tourDate: "19.08.2015", tourGuide: "Ron Johnson"),
        ScheduledEntry(tourTime: "07", tourTimeAmorPM: "PM", tourName: "Reno", tourDate: "10.12.2015", tourGuide: "Rohit Sharma"),
        ScheduledEntry(tourTime: "12", tourTimeAmorPM: "AM", tourName: "LA Night Club", tourDate: "13.05.2015", tourGuide: "Fernando Lopez"),
        ScheduledEntry(tourTime: "03", tourTimeAmorPM: "PM", tourName: "Santa Monica", tourDate: "24.03.2015", tourGuide: "Django Williams")
    ]
    
}
