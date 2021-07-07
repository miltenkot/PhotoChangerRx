//
//  FilterService.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 07/07/2021.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    
    private var context: CIContext
    
    init(context: CIContext) {
        self.context = context
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filterImage in
                observer.onNext(filterImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage,  completion: @escaping ((UIImage) -> ())) {
         let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        
        if let sourceImage = CIImage(image: inputImage){
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImg = self.context.createCGImage(filter.outputImage!,
                                                      from: filter.outputImage!.extent){
                let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                
                completion(processedImage)
                
            }
        }
    }
}
