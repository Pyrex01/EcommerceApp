//
//  Utilites.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//

import Foundation
import UIKit

class Common {
    static func image(from text: String) -> UIImage? {
        let size = CGSize(width: 200, height: 100) // set the desired image size
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { ctx in
            // draw the text in the image context
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            text.draw(with: CGRect(origin: .zero, size: size), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        return image
    }

}
