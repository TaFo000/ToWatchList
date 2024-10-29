import UIKit
import SnapKit

class DetailCardViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let blueColor = UIColor(red: 112/255.0, green: 117/255.0, blue: 244/255.0, alpha: 1)

    var card: Card?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setInfo(with: card)
    }

    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true

        imageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.height.equalTo(400)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
        }

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = blueColor
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
    }

    func setInfo(with card: Card?) {
        guard let card = card else { return }
        imageView.image = card.image
        titleLabel.text = card.title
        descriptionLabel.text = card.description
    }
}
