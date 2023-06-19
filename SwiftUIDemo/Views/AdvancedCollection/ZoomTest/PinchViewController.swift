//
//  PinchViewController.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/12/26.
//

import Foundation
import SwiftUI

class PinchViewController: UIViewController {
    var imagename: String = ""
    
    init(imagename: String) {
        super.init(nibName: nil, bundle: nil)
        self.imagename = imagename
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: imagename) {
            let scrollView = PinchScrollView(frame: view.bounds)
            view.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            // apply constraints
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
            scrollView.updateView(image: image)
        }        
    }
}

class PinchScrollView: UIScrollView {
    var imageView: UIImageView? = nil
    
    lazy var doubleTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
        tap.numberOfTapsRequired = 2
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // set scroll view property
        self.delegate = self
        self.bouncesZoom = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCenterView()
    }
    
    func updateView(image: UIImage) {
        self.imageView?.removeFromSuperview()
        self.imageView = nil
        self.imageView = UIImageView(image: image)
        
        if let imageView = imageView {
            self.addSubview(imageView)
            self.configure(size: image.size)
        }
    }
    
    private func configure(size: CGSize) {
        self.contentSize = size
        self.setZoomScale()
        self.imageView?.addGestureRecognizer(self.doubleTapGesture)
        self.imageView?.isUserInteractionEnabled = true
    }
    
    private func setZoomScale() {
        var minScale: CGFloat = 1.0
        var maxScale: CGFloat = 1.0
        
        defer {
            self.minimumZoomScale = minScale
            self.maximumZoomScale = maxScale
            self.zoomScale = minScale
        }
        
        let boundsSize = self.bounds.size
        if let imageView = imageView {
            let imageSize = imageView.bounds.size
            
            let xScale = boundsSize.width / imageSize.width
            let yScale = boundsSize.height / imageSize.height
            minScale = min(xScale, yScale)
            
            if minScale < 0.1 {
                maxScale = 0.3
            }

            if minScale >= 0.1 && minScale < 0.5 {
                maxScale = 0.7
            }

            if minScale >= 0.5 {
                maxScale = max(1.0, minScale)
            }
        }
    }
    
    private func setCenterView() {
        let boundsSize = self.bounds.size
        var frameCenter: CGRect = self.imageView?.frame ?? .zero
        
        if frameCenter.size.width < boundsSize.width {
            frameCenter.origin.x = (boundsSize.width - frameCenter.size.width) / 2
        } else {
            frameCenter.origin.x = 0
        }
        
        if frameCenter.size.height < boundsSize.height {
            frameCenter.origin.y = (boundsSize.height - frameCenter.size.height) / 2
        } else {
            frameCenter.origin.y = 0
        }
        
        self.imageView?.frame = frameCenter
    }
    
    // MARK: - Tap gesture
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    private func zoom(point: CGPoint, animated: Bool) {
        let scale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let zoomScale = scale == minScale ? maxScale : minScale
        let zoomRect = self.zoomRect(scale: zoomScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
}

// MARK: - UIScrollViewDelegate
extension PinchScrollView: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        return self.setCenterView()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
