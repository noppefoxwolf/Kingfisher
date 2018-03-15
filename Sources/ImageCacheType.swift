//
//  ImageCacheType.swift
//  Kingfisher-iOS
//
//  Created by Tomoya Hirano on 2018/03/13.
//  Copyright © 2018年 Wei Wang. All rights reserved.
//

import Foundation

/**
 Cache type of a cached image.
 
 - None:   The image is not cached yet when retrieving it.
 - Memory: The image is cached in memory.
 - Disk:   The image is cached in disk.
 */
public enum CacheType {
  case none, memory, disk
  
  public var cached: Bool {
    switch self {
    case .memory, .disk: return true
    case .none: return false
    }
  }
}

/// It represents a task of retrieving image. You can call `cancel` on it to stop the process.
public typealias RetrieveImageDiskTask = DispatchWorkItem
/// Closure that defines the disk cache path from a given path and cacheName.
public typealias DiskCachePathClosure = (String?, String) -> String

public protocol ImageCacheType {
  static var `default`: AnyImageCache { get }
    
//  init(name: String, path: String?, diskCachePathClosure: DiskCachePathClosure)
  
  @discardableResult
  func retrieveImage(forKey key: String,
                          options: KingfisherOptionsInfo?,
                          completionHandler: ((Image?, CacheType) -> Void)?) -> RetrieveImageDiskTask?
  
  func store(_ image: Image,
              original: Data?,
              forKey key: String,
              processorIdentifier identifier: String,
              cacheSerializer serializer: CacheSerializer,
              toDisk: Bool,
              completionHandler: (() -> Void)?)
  
  func imageCachedType(forKey key: String, processorIdentifier identifier: String) -> CacheType
}
