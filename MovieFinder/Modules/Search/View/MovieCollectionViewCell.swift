//
//  MovieCollectionViewCell.swift
//  MovieFinder
//
//  Created by apple on 06/04/21.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .clear
        return iv
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.sd_cancelCurrentImageLoad()
        movieTitle.text = nil
    }
    
    func update(with model: MovieCellViewModel) {
        movieTitle.text = model.movieName
        guard let urlString = model.imageURLString else { return }
        movieImageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil, options: [], context: nil)
    }
}

private extension MovieCollectionViewCell {
    
    func build() {
        buildHeirarchy()
        buildConstraints()
    }
    
    func buildHeirarchy() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitle)
    }
    
    func buildConstraints() {
        movieImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(movieTitle.snp.top).offset(-8)
        }
        movieTitle.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
