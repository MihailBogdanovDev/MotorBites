import Foundation
import SwiftUI
import FirebaseStorage
import SDWebImage
import FirebaseStorageUI

// TODO - Replace placeholder string to asset from your project
let placeholder = UIImage(named: "photo")!

/// SwiftUI View that will display placeholder, then Firebase Storage Image
struct StorageUIImage : View {
  
  /// Init
  /// - Parameter path: firebase path of the image (ex.: "storageFolder/subfolder/filename.jpg")
  init(path: String) {
      self.imageLoader = LiveLoader(path)
  }
  
  /// Image Loader observed object that will trigger image changes.
  @ObservedObject private var imageLoader: LiveLoader
  
  var body: some View {
      Image(uiImage: imageLoader.image ?? placeholder)
  }
}

/// LiveLoader class that will try to return image from memory cache, then disk cache, then network.
final class LiveLoader : ObservableObject {
  /// Published image object to be observed
  @Published var image: UIImage? = nil
  
  init(_ path: String){
      let storage = Storage.storage()
      let ref = storage.reference().child(path)
      let url = NSURL.sd_URL(with: ref) as? URL
      if let image = SDImageCache.shared.imageFromCache(forKey: SDWebImageManager.shared.cacheKey(for: url)) {
          // If image was present form memory cache, we display it
          print("Image loaded from memory cache")
          self.image = image
      } else if let image = SDImageCache.shared.imageFromDiskCache(forKey: SDWebImageManager.shared.cacheKey(for: url)) {
          // Else if image was present form disk cache, we cache it in memory again and display it
          print("Image loaded from disk cache")
          SDImageCache.shared.store(self.image, forKey: SDWebImageManager.shared.cacheKey(for: url), toDisk: false) {
              self.image = image
          }
      } else {
          // Else we fetch it from network, cache it in memory and disk, then display it
          print("Image downloaded")
          // maxSize can be set as parameter if needed
          ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print("\(error)")
              }
              guard let data = data else { return }
              SDImageCache.shared.store(self.image, forKey: SDWebImageManager.shared.cacheKey(for: url)) {
                  DispatchQueue.main.async {
                      self.image = UIImage.init(data: data)
                  }
              }
          }
      }
  }
}
