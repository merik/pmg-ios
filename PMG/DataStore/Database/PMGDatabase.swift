//
//  PMGDatabase.swift
//  PMG
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import GRDB

class PMGDatabase {
    static let shared = PMGDatabase()
    var dbQueue: DatabaseQueue!
    private init() {
        
    }
    
    // Call this in AppDelegate.didFinishLaunchingWithOptions
    func setupDatabase(_ application: UIApplication) throws {
        let databaseURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("pmg.sqlite")
        print(databaseURL)
        dbQueue = try PMGDatabase.openDatabase(atPath: databaseURL.path)
        dbQueue.setupMemoryManagement(in: application)
        
    }
    
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        // Connect to the database
        let dbQueue = try DatabaseQueue(path: path)
        // Define the database schema
        try migrator.migrate(dbQueue)
        return dbQueue
  
    }
    
    /// The DatabaseMigrator that defines the database schema.
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        // 1st migration
        migrator.registerMigration("v1.0") { db in
            try db.create(table: "movie") { t in
                t.column("episodeId", .integer).primaryKey(onConflict: .replace, autoincrement: false)
                t.column("title", .text)
                t.column("director", .text)
                t.column("producer", .text)
                t.column("openingCrawl", .text)
                t.column("releaseDate", .text)
            }
            
            try db.create(table: "character") { t in
                t.column("url", .text).primaryKey(onConflict: .replace, autoincrement: false)
                t.column("name", .text)
                t.column("birthYear", .text)
                t.column("eyeColor", .text)
                t.column("gender", .text)
                t.column("height", .text)
                t.column("mass", .text)
                t.column("skinColor", .text)
                
            }
            
            try db.create(table: "movieCharacters") { t in
                t.column("id", .text).primaryKey(onConflict: .replace, autoincrement: false)
                t.column("episodeId", .text).references("movie", onDelete: .cascade)
                t.column("characterUrl", .text)
            }
           
        }
        
        // // Migrations for future application versions will be inserted here:
        //        migrator.registerMigration(...) { db in
        //            ...
        //        }
        
        return migrator
    }
}
