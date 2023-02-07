//
// Created by Tom Sartori on 2/7/23.
//

import Foundation

class TrackModel {

    public var trackName: String;
    public var artistName: String
    public var collectionName: String
    public var releaseDate: String

    init(trackName: String, artistName: String, collectionName: String, releaseDate: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.releaseDate = releaseDate
    }
}
