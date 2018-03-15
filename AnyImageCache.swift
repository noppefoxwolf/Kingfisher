//
//  AnyImageCache.swift
//  Kingfisher-iOS
//
//  Created by Tomoya Hirano on 2018/03/13.
//  Copyright © 2018年 Wei Wang. All rights reserved.
//

import Foundation

class AnyImageCacheBox {
  class var `default`: AnyImageCacheBox { fatalError() }
  
  @discardableResult
  func retrieveImage(forKey key: String,
                     options: KingfisherOptionsInfo?,
                     completionHandler: ((Image?, CacheType) -> Void)?) -> RetrieveImageDiskTask? {
    fatalError()
  }
  
  func store(_ image: Image,
             original: Data?,
             forKey key: String,
             processorIdentifier identifier: String,
             cacheSerializer serializer: CacheSerializer,
             toDisk: Bool,
             completionHandler: (() -> Void)?) {
    fatalError()
  }
  
  func imageCachedType(forKey key: String, processorIdentifier identifier: String) -> CacheType {
    fatalError()
  }
}

class ImageCacheBox<X: ImageCacheType> : AnyImageCacheBox {
  static override var `default`: AnyImageCacheBox { fatalError() }
  
  init(_ base: X) {
    self.base = base
  }
  private let base: X
  
  override func retrieveImage(forKey key: String, options: KingfisherOptionsInfo?, completionHandler: ((Image?, CacheType) -> Void)?) -> RetrieveImageDiskTask? {
    return base.retrieveImage(forKey: key, options: options, completionHandler: completionHandler)
  }
  
  override func store(_ image: Image, original: Data?, forKey key: String, processorIdentifier identifier: String, cacheSerializer serializer: CacheSerializer, toDisk: Bool, completionHandler: (() -> Void)?) {
    base.store(image, original: original, forKey: key, processorIdentifier: identifier, cacheSerializer: serializer, toDisk: toDisk, completionHandler: completionHandler)
  }
  
  override func imageCachedType(forKey key: String, processorIdentifier identifier: String) -> CacheType {
    return base.imageCachedType(forKey: key, processorIdentifier: identifier)
  }
}

public final class AnyImageCache: ImageCacheType {
  public static var `default`: AnyImageCache { return AnyImageCache.init(box: AnyImageCacheBox.default) }
  
  @discardableResult
  public func retrieveImage(forKey key: String, options: KingfisherOptionsInfo?, completionHandler: ((Image?, CacheType) -> Void)?) -> RetrieveImageDiskTask? {
    return box.retrieveImage(forKey: key, options: options, completionHandler: completionHandler)
  }
  
  public func store(_ image: Image, original: Data?, forKey key: String, processorIdentifier identifier: String, cacheSerializer serializer: CacheSerializer, toDisk: Bool, completionHandler: (() -> Void)?) {
    box.store(image, original: original, forKey: key, processorIdentifier: identifier, cacheSerializer: serializer, toDisk: toDisk, completionHandler: completionHandler)
  }
  
  public func imageCachedType(forKey key: String, processorIdentifier identifier: String) -> CacheType {
    return box.imageCachedType(forKey: key, processorIdentifier: identifier)
  }
  
  private init(box: AnyImageCacheBox) {
    self.box = box
  }
  public init<X: ImageCacheType>(_ base: X) {
    box = ImageCacheBox(base)
  }
  
  private let box: AnyImageCacheBox
}
