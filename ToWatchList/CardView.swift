
import UIKit
import SnapKit

class CardView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let cardWrapper = UIView()
    private let blueColor =  UIColor(red: 112/255.0, green: 117/255.0, blue: 244/255.0, alpha:  1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = blueColor.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5

        addSubview(cardWrapper)

        cardWrapper.addSubview(imageView)
        cardWrapper.addSubview(titleLabel)

        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true

        cardWrapper.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(cardWrapper.snp.width).multipliedBy(1.5)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(cardWrapper).multipliedBy(0.9) 
            make.height.equalTo(imageView.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = blueColor
    }

    func setInfo(with card: Card) {
        imageView.image = card.image
        titleLabel.text = card.title
    }
}
