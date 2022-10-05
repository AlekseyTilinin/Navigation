//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Aleksey on 04.10.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photosTitle: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return layout
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DeafaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        addSubview(photosTitle)
        addSubview(arrowImageView)
        addSubview(photoCollectionView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
        
            photosTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            photosTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            
            arrowImageView.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            photoCollectionView.topAnchor.constraint(equalTo: photosTitle.bottomAnchor, constant: 12),
            photoCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            photoCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            photoCollectionView.heightAnchor.constraint(equalToConstant: itemSize),
            photoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
