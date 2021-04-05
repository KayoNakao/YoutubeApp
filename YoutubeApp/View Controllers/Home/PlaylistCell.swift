//
//  PlaylistCell.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-03.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import SDWebImage

class PlaylistCell: BaseTableViewCell {

    private lazy var thumbnail: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Font.captionBold
        label.textColor = .white
        return label
    }()

    private lazy var videoCountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.captionRegular
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PlaylistCell {
    func configureLayout() {
        contentView.addSubview(thumbnail)
        thumbnail.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(16)
            make.centerY.equalTo(thumbnail.snp.centerY)
            make.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(videoCountLabel)
    }
}

extension PlaylistCell {
    func configure(thumbnailUrl: String, titleText: String, numberOfVideos: Int) {
        if let url = URL(string: thumbnailUrl) {
            thumbnail.sd_setImage(with: url, placeholderImage: nil) { (image, _, _, _) in
                let crop =  image?.cropToBounds(width: 50, height: 50)
                self.thumbnail.image = crop
            }
        }
        
        title.text = titleText
        videoCountLabel.text = numberOfVideos == 1
            ?  String(format: Localizable.Home.video, numberOfVideos)
            : String(format: Localizable.Home.videos, numberOfVideos)
    }
    
}
