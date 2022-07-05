//
//  BookCell.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/04.
//

import UIKit


class BookCell: UITableViewCell {

    // MARK: UI
    
    lazy var containerStackView = UIStackView(arrangedSubviews: [thumbnailView, infoStackView])
    
    lazy var infoStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, publishedDateLabel])
    
    let thumbnailView = UIImageView()
    
    let titleLabel = UILabel()
    
    let authorLabel = UILabel()
    
    let publishedDateLabel = UILabel()
    
    
    // MARK: Initializing
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAttributes()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        selectionStyle = .none
        
        containerStackView.axis = .horizontal
        containerStackView.alignment = .top
        containerStackView.spacing = 10
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.spacing = 5
        
        thumbnailView.contentMode = .scaleAspectFill
        thumbnailView.layer.masksToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .systemGray
        
        publishedDateLabel.font = .systemFont(ofSize: 12)
        publishedDateLabel.textColor = .systemGray
    }

    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        thumbnailView.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    func configure(with book: Book) {
        thumbnailView.loadImage(
            urlString: book.volumeInfo.imageLinks?.thumbnail,
            failedHandler: { [weak self] _ in
                self?.thumbnailView.image = UIImage(systemName: "book")
            }
        )
        
        titleLabel.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors?.joined(separator: ", ")
        publishedDateLabel.text = book.volumeInfo.publishedDate
    }
    
}
