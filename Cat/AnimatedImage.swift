import SwiftUI
import UIKit

struct AnimatedImage: UIViewRepresentable {
    let imageName: String
    
    func makeUIView(context: Self.Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let asset = NSDataAsset(name: imageName),
           let image = UIImage.gif(data: asset.data) {
            imageView.image = image
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<AnimatedImage>) { }
}


extension UIImage {
    class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        var images: [UIImage] = []
        var totalDuration: TimeInterval = 0

        let frameCount = CGImageSourceGetCount(source)
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let frameDuration = frameDelayForImageAtIndex(index: i, source: source)
                totalDuration += frameDuration
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }

        return UIImage.animatedImage(with: images, duration: totalDuration)
    }
    
    private class func frameDelayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.07

        // Get dictionaries
        let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let frameProperties = cfFrameProperties as! Dictionary<String, AnyObject>
        let gifProperties = frameProperties[kCGImagePropertyGIFDictionary as String] as! Dictionary<String, AnyObject>

        // Get delay time
        var delayObject: AnyObject = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String]!
        if delayObject.doubleValue == 0 {
            delayObject = gifProperties[kCGImagePropertyGIFDelayTime as String]!
        }

        delay = delayObject as! Double
        if delay < 0.07 {
            delay = 0.07
        }

        return delay
    }
}

