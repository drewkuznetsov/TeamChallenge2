//
//  ImageLoaderService.swift
//  TeamChallenge2
//
//  Created by Dmitry Lorents on 29.03.2025.
//

import Kingfisher
import UIKit

public protocol IImageLoaderService {
    func fetchImage(for urlString: String) async -> UIImage?
    func fetchImage(for url: URL) async -> UIImage?
    func fetchImages(for urls: [URL]) async -> [UIImage?]
    func fetchImages(for urls: [String]) async -> [UIImage?]
    func fetchImagesMap(for urls: [URL]) async -> [URL: UIImage]
    func fetchImagesMap(for urlsString: [String]) async -> [String: UIImage]
}

public actor ImageLoaderService: IImageLoaderService {
    let loader = KingfisherManager.shared
    
    public func fetchImage(for urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        return await fetchImage(for: url)
    }
    
    public func fetchImage(for url: URL) async -> UIImage? {
        try? await loader.retrieveImage(with: url).image
    }
    
    
    public func fetchImagesMap(for urlsString: [String]) async -> [String: UIImage] {
        await withTaskGroup(of: (url: String, image: UIImage?).self) { group in
            urlsString.forEach { url in
                group.addTask { await (url, self.fetchImage(for: url))}
            }
            return await group.reduce(into: [:], { $0[$1.url] = $1.image })
        }
    }
    
    public func fetchImagesMap(for urls: [URL]) async -> [URL: UIImage] {
        await withTaskGroup(of: (url: URL, image: UIImage?).self) { group in
            urls.forEach { url in
                group.addTask { await (url, self.fetchImage(for: url))}
            }
            return await group.reduce(into: [:], { $0[$1.url] = $1.image })
        }
    }
    
    public func fetchImages(for urls: [URL]) async -> [UIImage?] {
        let imagesMap = await fetchImagesMap(for: urls)
        return urls.map { imagesMap[$0] }
    }
    
    public func fetchImages(for urls: [String]) async -> [UIImage?] {
        let imagesMap = await fetchImagesMap(for: urls)
        return urls.map { imagesMap[$0] }
    }
}
