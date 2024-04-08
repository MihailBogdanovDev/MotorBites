//
//  CatalogProvider.swift
//  DemoApp1
//
//  Created by Mihail Bogdanov on 09/03/2024.
//

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model that creates a custom catalog with a reference signature and metadata.
*/

import ShazamKit

struct CatalogProvider {
    
    static func catalog() throws -> SHCustomCatalog? {
        guard let signaturePath = Bundle.main.url(forResource: "TheHairyBikersGoWestS01E01", withExtension: "shazamsignature") else {
            return nil
        }
        
        let signatureData = try Data(contentsOf: signaturePath)
        let signature = try SHSignature(dataRepresentation: signatureData)
        
        let mediaItem = SHMediaItem(properties: [.title: "The Hairy Bikers Go West", .subtitle: "S01 E01", .episode: 1])
        
        let customCatalog = SHCustomCatalog()
        try customCatalog.addReferenceSignature(signature, representing: [mediaItem])
        
        return customCatalog
    }
}

