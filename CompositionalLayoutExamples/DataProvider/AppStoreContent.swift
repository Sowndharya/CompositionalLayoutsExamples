//
//  AppStoreContent.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

struct App {
    
    var tag: Tag
    var appName: String
    var appDesc: String
    var bannerImage: UIImage
    var isInstalled: Bool
    var isBannered: Bool
    
    init(tag: Tag, appName: String, appDesc: String, bannerImage: UIImage, isInstalled: Bool) {
        self.tag = tag
        self.appName = appName
        self.appDesc = appDesc
        self.bannerImage = bannerImage
        self.isInstalled = isInstalled
        self.isBannered = false
    }
    
    enum Tag {
        case featured
        case forKids
        case whatToWatch
        case getCreative
        case trySomethingNew
        case workout
        case newAppsWeLove
        case experienceItInAR
        case autofillYourPasswords
        
        var name: String {
            switch self {
            case .featured: return "Featured"
            case .forKids: return "For kids"
            case .whatToWatch: return "What to watch"
            case .getCreative: return "Get creative"
            case .trySomethingNew: return "Try something new"
            case .workout: return "Workout"
            case .newAppsWeLove: return "New Apps we love"
            case .experienceItInAR: return "Exprience it in AR"
            case .autofillYourPasswords: return "Autofill your passwords"
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .featured: return UIColor.systemPink
            case .forKids: return UIColor.systemTeal
            case .whatToWatch: return UIColor.systemBlue
            case .getCreative: return UIColor.systemTeal
            case .trySomethingNew: return UIColor.systemYellow
            case .workout: return UIColor.systemPink
            case .newAppsWeLove: return UIColor.systemYellow
            case .experienceItInAR: return UIColor.systemFill
            case .autofillYourPasswords: return UIColor.systemBlue
            }
        }
    }
}

struct AppsDataProvider {
    
    enum Section {
        case banner
        case category(tag: App.Tag)
        
        var name: String {
            switch self {
            case .banner: return ""
            case .category(let tag): return tag.name
            }
        }
    }
    
    var section: Section
    var apps: [App]
    
    static func generateFakeApps() -> [AppsDataProvider] {
        
        let appsArray = [App(tag: .whatToWatch,
                             appName: "Web Series",
                             appDesc: "Daily dose of entertainment",
                             bannerImage: UIImage(named: "ASImage3")!,
                             isInstalled: true),
                         
                         App(tag: .featured,
                             appName: "Sticker Chat",
                             appDesc: "Cheer on with stickers!",
                             bannerImage: UIImage(named: "ASImage6")!,
                             isInstalled: false),
                         
                         App(tag: .forKids,
                             appName: "Disney Episodes",
                             appDesc: "Watch and read your favorites",
                             bannerImage: UIImage(named: "ASImage1")!,
                             isInstalled: true),
                         
                         App(tag: .whatToWatch,
                             appName: "Crickfest",
                             appDesc: "Watch live cricket",
                             bannerImage: UIImage(named: "ASImage2")!,
                             isInstalled: false),
                         
                         App(tag: .featured,
                             appName: "Flipflop",
                             appDesc: "Share your funny videos",
                             bannerImage: UIImage(named: "ASImage4")!,
                             isInstalled: false),
                         
                         App(tag: .getCreative,
                             appName: "Canonist",
                             appDesc: "Easily create photomontages",
                             bannerImage: UIImage(named: "ASImage5")!,
                             isInstalled: true),
                         
                         App(tag: .trySomethingNew,
                             appName: "Ing - English Vocabulary",
                             appDesc: "Daily vocabulary exercises",
                             bannerImage: UIImage(named: "ASImage7")!,
                             isInstalled: true),
                         
                         App(tag: .workout,
                             appName: "Eight - 8 Minute Workout",
                             appDesc: "Quick bodyweight workouts",
                             bannerImage: UIImage(named: "ASImage8")!,
                             isInstalled: true),
                         
                         App(tag: .workout,
                             appName: "Fantastic Home Workout",
                             appDesc: "Workout & fitness exercises",
                             bannerImage: UIImage(named: "ASImage9")!,
                             isInstalled: true),
                         
                         App(tag: .workout,
                             appName: "Sworkit Fitness",
                             appDesc: "Workouts plans made simple",
                             bannerImage: UIImage(named: "ASImage10")!,
                             isInstalled: false),
                         
                         App(tag: .workout,
                             appName: "Sweat It Out",
                             appDesc: "Run, play, reduce",
                             bannerImage: UIImage(named: "ASImage11")!,
                             isInstalled: true),
                         
                         App(tag: .workout,
                             appName: "Bodywieghtless",
                             appDesc: "Workouts to stay healthy",
                             bannerImage: UIImage(named: "ASImage12")!,
                             isInstalled: true),
                         
                         App(tag: .workout,
                             appName: "Build the bicepts",
                             appDesc: "Toned arms and more",
                             bannerImage: UIImage(named: "ASImage13")!,
                             isInstalled: false),
                         
                         App(tag: .newAppsWeLove,
                             appName: "Keep it Cleaner",
                             appDesc: "Live a better life!",
                             bannerImage: UIImage(named: "ASImage16")!,
                             isInstalled: true),
                         
                         App(tag: .newAppsWeLove,
                             appName: "Swish: Marketing Video Editor",
                             appDesc: "Advertise your brand online",
                             bannerImage: UIImage(named: "ASImage14")!,
                             isInstalled: true),
                        
                         App(tag: .newAppsWeLove,
                             appName: "Curio: Hear Journalism",
                             appDesc: "FT Guardian, Economist",
                             bannerImage: UIImage(named: "ASImage15")!,
                             isInstalled: false),
                         
                         App(tag: .experienceItInAR,
                             appName: "Filmr - Video & Photo Editor",
                             appDesc: "Movie maker, filter, easy-to-use",
                             bannerImage: UIImage(named: "ASImage17")!,
                             isInstalled: false),
                         
                         App(tag: .experienceItInAR,
                             appName: "App in the air",
                             appDesc: "Fly smarter",
                             bannerImage: UIImage(named: "ASImage18")!,
                             isInstalled: false),
                         
                         App(tag: .experienceItInAR,
                             appName: "Morpholio Trace - Sketch CAD",
                             appDesc: "Design and architecture drawing",
                             bannerImage: UIImage(named: "ASImage19")!,
                             isInstalled: false),
                         
                         App(tag: .newAppsWeLove,
                             appName: "Remember: Password Manager",
                             appDesc: "Password man_ars",
                             bannerImage: UIImage(named: "ASImage20")!,
                             isInstalled: true),
                         
                         App(tag: .newAppsWeLove,
                             appName: "Dashboard Password Manager",
                             appDesc: "Secure password storage vault",
                             bannerImage: UIImage(named: "ASImage21")!,
                             isInstalled: false)]
        
        var appSections = [AppsDataProvider]()

        for (appIndex, app) in appsArray.enumerated() {
            
            if appIndex < 7 {
                
                if let bannerSection = appSections.firstIndex(where: {$0.section.name == AppsDataProvider.Section.banner.name}) {
                    
                    appSections[bannerSection].apps.append(app)
                
                } else {
                    
                    let bannerSection = AppsDataProvider(section: .banner, apps: [app])
                    appSections.insert(bannerSection, at: 0)
                }
        
            } else {
                
                if let categorySection = appSections.firstIndex(where: {$0.section.name == app.tag.name}) {
                    
                    appSections[categorySection].apps.append(app)
                
                } else {
                    
                    let categorySection = AppsDataProvider(section: .category(tag: app.tag), apps: [app])
                    appSections.append(categorySection)
                }
            }
        }
        
        return appSections
    }
}
