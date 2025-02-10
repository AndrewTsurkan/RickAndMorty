//
//  InstallCell.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
import UIKit

class RickInfoCell: UITableViewCell {
    
    static var reusedId: String {
        return String(describing: self)
    }
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    private let mainStackView = UIStackView()
    private let nameAndStatusStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let statusView = UIView()
    private let statusLabel = UILabel()
    private let nameLabel = UILabel()
    private let genderAndRaceLabel = UILabel()
    private let watchEpisodesButton = UIButton()
    private let planetNameStackView = UIStackView()
    private var vectorImageView = UIImageView()
    private let planetNameLabel = UILabel()
    
    
    var responseResult: ResponseResult? {
        didSet{
            reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupPosterImageView()
        setupMainStackView()
        setupNameAndStatus()
        setupGenderAndRace()
        setupButtonWatchEpisodes()
        setupLabelPlanets()
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        statusLabel.text = nil
        nameLabel.text = nil
        genderAndRaceLabel.text = nil
        planetNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMainStackView() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.spacing = 10
        
        [mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
         mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
         mainStackView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 10),
         mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
         mainStackView.heightAnchor.constraint(equalToConstant: 120)].forEach { $0.isActive = true }
    }
    
    func setupPosterImageView() {
        addSubview(posterImageView)
        posterImageView.layer.cornerRadius = 40
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.backgroundColor = .black
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        [posterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
         posterImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
         posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
         posterImageView.heightAnchor.constraint(equalToConstant: 120),
         posterImageView.widthAnchor.constraint(equalToConstant: 120)].forEach { $0.isActive = true }
    }
    
    func setupNameAndStatus() {
        mainStackView.addArrangedSubview(nameAndStatusStackView)
        nameAndStatusStackView.axis = .horizontal
        nameAndStatusStackView.distribution = .fill
        nameAndStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [nameAndStatusStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
         nameAndStatusStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
         nameAndStatusStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
         nameAndStatusStackView.widthAnchor.constraint(equalToConstant: 25)].forEach {$0.isActive = true}
        
        nameAndStatusStackView.addArrangedSubview(nameLabel)
        nameAndStatusStackView.addArrangedSubview(statusView)
        
        nameAndStatusStackView.alignment = .leading
        nameAndStatusStackView.spacing = 16
        
        nameLabel.font = UIFont.systemFont(ofSize: 21)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 12.5
        
        statusView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        
        statusView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        [statusLabel.leftAnchor.constraint(equalTo: statusView.leftAnchor, constant: 10),
         statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 3),
         statusLabel.rightAnchor.constraint(equalTo: statusView.rightAnchor, constant: -10),
         statusLabel.bottomAnchor.constraint(equalTo: statusView.bottomAnchor, constant: -3)].forEach { $0.isActive = true }
        
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        statusLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func setupGenderAndRace() {
        mainStackView.addArrangedSubview(genderAndRaceLabel)
        genderAndRaceLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setupButtonWatchEpisodes() {
        mainStackView.addArrangedSubview(watchEpisodesButton)
        watchEpisodesButton.translatesAutoresizingMaskIntoConstraints = false
        watchEpisodesButton.layer.cornerRadius = 17
        watchEpisodesButton.backgroundColor = UIColor(red: 255.0/255.0, green: 107.0/255.0, blue: 0.0, alpha: 0.1)
        watchEpisodesButton.setTitleColor(UIColor(red: 255, green: 107, blue: 0), for: .normal)
        watchEpisodesButton.setTitle("▶ Watch episodes", for: .normal)
        watchEpisodesButton.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        
        [watchEpisodesButton.heightAnchor.constraint(equalToConstant: 35),
         watchEpisodesButton.widthAnchor.constraint(equalToConstant: 148)].forEach { $0.isActive = true }
    }
    
    func setupLabelPlanets() {
        planetNameStackView.addArrangedSubview(vectorImageView)
        vectorImageView.translatesAutoresizingMaskIntoConstraints = false
        vectorImageView.image = UIImage(named: "Vector")
        
        [vectorImageView.widthAnchor.constraint(equalToConstant: 10),
         vectorImageView.heightAnchor.constraint(equalToConstant: 12)].forEach{ $0.isActive = true }
        
        planetNameStackView.addArrangedSubview(planetNameLabel)
        planetNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        mainStackView.addArrangedSubview(planetNameStackView)
        planetNameStackView.axis = .horizontal
        planetNameStackView.alignment = .fill
        planetNameStackView.spacing = 8
    }
    
    func reloadData() {
        guard let responseResult else {
            return
        }
        downloadPoster()
        nameLabel.text = responseResult.name
        statusLabel.text = responseResult.status
        genderAndRaceLabel.text = "\(responseResult.species ?? ""), \(responseResult.gender?.lowercased() ?? "")"
        planetNameLabel.text = responseResult.origin?.name
        
        let status = Status(rawValue: responseResult.status ?? "")
        statusLabel.text = status?.text
        statusLabel.textColor = status?.textColor
        statusView.backgroundColor = status?.backgroundColor
    }
    
    func downloadPoster() {
        guard let url = responseResult?.image else {
            return
        }
        
        let urlImage = URL(string:url)
        
        if let cachedImage = PostersCache.shared.getImage(url: url) {
            posterImageView.image = cachedImage
        } else {
            NetworkService().request(urlString: urlImage!.absoluteString) { [weak self] result in
                switch result {
                case let .success(data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.posterImageView.image = UIImage(named: "play.slash")
                    }
                }
            }
        }
    }
}

extension RickInfoCell {
    
    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var text: String {
            switch self{
            case .alive:
                return "ALIVE"
            case .dead:
                return "DEAD"
            case .unknown:
                return "UNKNOWN"
            }
        }
        
        var backgroundColor: UIColor{
            switch self{
            case.alive:
                return UIColor(red: 199, green: 255, blue: 185)
            case.dead:
                return UIColor(red: 255, green: 232, blue: 224)
            case.unknown:
                return UIColor(red: 238, green: 238, blue: 238)
            }
        }
        
        var textColor: UIColor{
            switch self{
            case.alive:
                return UIColor(red: 49, green: 159, blue: 22)
            case.dead:
                return UIColor(red:233 , green: 56, blue: 0)
            case.unknown:
                return UIColor(red: 160, green: 160, blue: 160)
            }
        }
    }
}
