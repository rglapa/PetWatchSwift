//
//  FileManagerExtensions.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/10/24.
//

import Foundation

extension FileManager {
    
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        guard let documentDirectory = documentDirectory else { return nil }
        let fileName = sourceURL.lastPathComponent
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print("Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    /// Removes an item with the specified file URL from the document directory, if present
    ///
    
    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory = documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print("Unable to remove file: \(error.localizedDescription)")
            }
        }
    }
    
    /// Returns the contents of the specified directory as an array of URLs.
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        // The URL must be a directory
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue else {
            return []
        }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print("Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}
