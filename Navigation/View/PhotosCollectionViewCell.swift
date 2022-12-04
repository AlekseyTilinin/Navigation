//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Aleksey on 06.10.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWithName(with name: String) {
        self.imageView.image = UIImage(named: name)
    }
    
    func setupWithImage(with image: UIImage) {
        self.imageView.image = image
    }
    func setupWithIndex(with index: Int) {
        self.imageView.image = photoCollection[index]
    }
    
    private func setupView() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
