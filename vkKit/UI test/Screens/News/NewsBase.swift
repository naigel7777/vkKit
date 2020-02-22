//
//  NewsBase.swift
//  UI test
//
//  Created by Nail Safin on 12.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
class NewsBase
{
   
    
    static func getNews() -> [News]
    {
        return[
            News(username: "James Zabiella",
                 avatar: "per2",
                 imagePath: ["ph1"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:22 10.01.2020"),
            News(username: "Jason Born",
                 avatar: "per3",
                 imagePath: ["ph1","ph2"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:25 10.01.2020"),
            News(username: "James Bond",
                 avatar: "per4",
                 imagePath: ["ph1","ph2","ph3"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:27 10.01.2020"),
            News(username: "James Bond",
                 avatar: "per4",
                 imagePath: ["ph1","ph2","ph3","ph4"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:27 10.01.2020"),
            News(username: "James Bond",
                 avatar: "per4",
                 imagePath: ["ph1","ph2","ph3","ph4","ph5"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:27 10.01.2020"),
            News(username: "James Bond",
                 avatar: "per4",
                 imagePath: ["ph1","ph2","ph3","ph4","ph5","ph1"],
                 textNews: "Long Text  Long Text Long Text Long Text Long Text Long Text Long Text ",
                 publicDate: "12:27 10.01.2020")
        ]
    }
}
