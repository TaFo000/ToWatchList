

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UIScrollViewDelegate {

    private let blueColor = UIColor(red: 112/255.0, green: 117/255.0, blue: 244/255.0, alpha: 1)

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    let searchController = UISearchController(searchResultsController: nil)
    let sortButton = UIBarButtonItem(title: "Отсортировать", style: .plain, target: nil, action: nil)

    var cards: [Card] = [
        Card(title: "Атака титанов", description: "Уже многие годы человечество ведёт борьбу с титанами — огромными существами, которые не обладают особым интеллектом, зато едят людей и получают от этого удовольствие. После продолжительной борьбы остатки человечества построили высокую стену, окружившую страну людей, через которую титаны пройти не могли. С тех пор прошло сто лет, люди мирно живут под защитой стены. Но однажды подростки Эрен и Микаса становятся свидетелями страшного события — участок стены разрушается супертитаном, появившимся прямо из воздуха. Титаны нападают на город, и дети в ужасе видят, как один из монстров заживо съедает мать Эрена. Мальчик клянётся, что убьёт всех титанов и отомстит за человечество.", image: UIImage(named: "attackOnTitan")!),
        Card(title: "Тетрадь смерти", description: "Старшекласснику Лайту Ягами в руки попадает тетрадь синигами Рюка. Каждый человек, чьё имя записать в эту тетрадку, умрёт, поэтому Лайт решает бороться со злом на земле.", image: UIImage(named: "deathNote")!),
        Card(title: "Монстр", description: "Доктор Кэндзо Тэнма — талантливый хирург, который работает в Германии. Однажды он спасает тяжело раненого мальчика. Этот случай послужит началом череды загадочных убийств, а спустя годы Кэндзо вновь столкнётся с тем, кого он когда-то спас от смерти.", image: UIImage(named: "monster")!),
        Card(title: "Евангелион", description: "14-летний Синдзи Икари направлялся на встречу с отцом, руководителем влиятельной организации NERV, когда Токио-3 подвергся нападению Ангела. С помощью капитана Мисато Кацураги парень добирается до подземной штаб-квартиры NERV и единственное, что он хочет сказать отцу — как сильно его ненавидит. Но на месте выясняется, что Синдзи должен прямо сейчас залезть в робота и сражаться с Ангелом.", image: UIImage(named: "evangelion")!),
        Card(title: "Полулюди", description: "Необычная форма жизни, которую называют Адзин, вселяется в главного героя этой истории, обычного школьника Кэй Нагай. Те, кто оказывается получеловеком, становятся бессмертными, обладают необычайной силой и ловкостью. Именно поэтому полулюди оказываются мишенью для правительства и на них начинается настоящая охота. Каждый из пойманных станет настоящей лабораторной крысой, над ними будут проводить жестокие эксперименты. Оказавшегося в ловушке получеловеку придется испытывать на себе тысячи смертей ежедневно, чтобы ученые смогли разгадать их феномен. Поэтому этим существам приходится прятаться отовсюду.", image: UIImage(named: "ajin")!)
    ]

    var filteredCards: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchController()
        setupNavigationBar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(collectionView)

        sortButton.tintColor = blueColor

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.tintColor = blueColor
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = sortButton
        sortButton.target = self
        sortButton.action = #selector(sortButtonTapped)
        navigationController?.navigationBar.tintColor = blueColor
    }

    @objc func sortButtonTapped() {
        cards.sort { $0.title.lowercased() < $1.title.lowercased() } // Сортировка в алфавитном порядке
        if searchController.isActive {
            filteredCards.sort { $0.title.lowercased() < $1.title.lowercased() }
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? filteredCards.count : cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        let card = searchController.isActive ? filteredCards[indexPath.row] : cards[indexPath.row]
        cell.setInfo(with: card)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding * 3
        return CGSize(width: collectionViewSize / 2, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = searchController.isActive ? filteredCards[indexPath.row] : cards[indexPath.row]
        let detailViewController = DetailCardViewController()
        detailViewController.card = card
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredCards = cards.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        } else {
            filteredCards = cards
        }
        collectionView.reloadData()
    }

   
}

class CardCollectionViewCell: UICollectionViewCell {
    let cardView = CardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setInfo(with card: Card) {
        cardView.setInfo(with: card)
    }
}
