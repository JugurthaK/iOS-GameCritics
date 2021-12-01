//
//  Game.swift
//  GameCritics
//
//  Created by Jugurtha Kabeche on 23/11/2021.
//

import Foundation
import ObjectMapper

class Game: Mappable {
    var id: Int?
    var name: String?
    var smallImageURL: String?
    var bigImageURL: String?
    var score: Int?
    var platform: String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        smallImageURL <- map["smallImageURL"]
        bigImageURL <- map["bigImageURL"]
        score <- map["score"]
        platform <- map["platform"]
    }
}
