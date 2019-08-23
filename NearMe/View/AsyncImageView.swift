//
//  AsyncImageView.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/22.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

/// AsyncImageView class represents a view object for downloading and setting its image
/// asynchronously. Set the imageUrl property to the needed url string and it handles the operation.
class AsyncImageView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override var contentMode: UIView.ContentMode {
        didSet {
            imageView.contentMode = contentMode
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            imageView.tintColor = tintColor
        }
    }
    
    /// Image url of the object to download.
    /// Setting this to non-nil value triggers the safe download operation
    var imageUrl: String? {
        didSet {
            // start download
            imageView.image = nil
            startImageFetch()
        }
    }
    
    override public  init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(imageView)
        contentMode = .scaleAspectFit
        clipsToBounds = true
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    private func startImageFetch() {
        guard let imageUrlToDownload = imageUrl else {
            return
        }
        
        // since cells can be scrolled very fast and they are re-used,
        // in order to prevent wrong image being set on a re-used cell because download finished
        // when this cell was being re-used as a new one (therefore having a new 'imageUrl'),
        // double check with the cache key(imageUrl)
        
        ImageDownloader.shared.image(for: imageUrlToDownload) {[weak self] (newImage, _) in
            if let weakSelf = self, let newImage = newImage, let imageUrlProperty = weakSelf.imageUrl, imageUrlProperty == imageUrlToDownload {
                weakSelf.image = newImage
            }
        }
    }
}
