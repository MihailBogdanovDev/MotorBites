/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Extension for custom ShazamKit media item properties.
*/

import ShazamKit

extension SHMediaItemProperty {
    static let episode = SHMediaItemProperty("episode")
}

extension SHMediaItem {
    var episode: Int? {
        return self[.episode] as? Int
    }
}
