//
//  InstallCell.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
import UIKit

class RickInfoCell: UITableViewCell {
    
    static var reusedId = "InstallCell"
    private var networkDataFetcher = NetworkDataFetcher()
    
    private let stackViewAllInfoСharacter = UIStackView()
    private let stackViewImageViewVectorAndLabelPlanets = UIStackView()
    private let viewLabelNameAndViewStatus = UIView()
    private let posterImageView = UIImageView()
    private let viewStatus = UIView()
    private let labelStatus = UILabel()
    private let labelName = UILabel()
    private let labelGenderAndRace = UILabel()
    private let buttonWatchEpisodes = UIButton()
    private var imageViewVector = UIImageView()
    private let labelPlanets = UILabel()

    var responseResult: ResponseResult?{
        didSet{
            reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPosterImageView()
        setupStackViewAllInfoHero()
        setupViewLabelNameAndViewStatus()
        setupLabelStatusAndViewStatus()
        setupLabelName()
        setupLabelGenderAndRace()
        setupButtonWatchEpisodes()
        setupImageViewVector()
        setupLabelPlanets()
        setupStackViewImageViewVectorAndLabelPlanets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackViewAllInfoHero() {
        addSubview(stackViewAllInfoСharacter)
        stackViewAllInfoСharacter.translatesAutoresizingMaskIntoConstraints = false
        stackViewAllInfoСharacter.axis = .vertical
        stackViewAllInfoСharacter.alignment = .leading
        stackViewAllInfoСharacter.spacing = 10
        
        [stackViewAllInfoСharacter.topAnchor.constraint(equalTo: topAnchor, constant: 20),
         stackViewAllInfoСharacter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
         stackViewAllInfoСharacter.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 10),
         stackViewAllInfoСharacter.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
         stackViewAllInfoСharacter.heightAnchor.constraint(equalToConstant: 120)].forEach { $0.isActive = true }
    }
    
    func setupStackViewImageViewVectorAndLabelPlanets() {
        stackViewAllInfoСharacter.addArrangedSubview(stackViewImageViewVectorAndLabelPlanets)
        stackViewImageViewVectorAndLabelPlanets.axis = .horizontal
        stackViewImageViewVectorAndLabelPlanets.alignment = .fill
        stackViewImageViewVectorAndLabelPlanets.spacing = 8
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
         posterImageView.widthAnchor.constraint(equalToConstant: 120)].forEach{ $0.isActive = true }
    }
    
    func setupViewLabelNameAndViewStatus() {
        stackViewAllInfoСharacter.addArrangedSubview(viewLabelNameAndViewStatus)
    }
    
    func setupLabelName() {
        viewLabelNameAndViewStatus.addSubview(labelName)
        labelName.font = UIFont.systemFont(ofSize: 21)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        [labelName.leftAnchor.constraint(equalTo: viewLabelNameAndViewStatus.leftAnchor),
         labelName.rightAnchor.constraint(equalTo: viewStatus.leftAnchor),
         labelName.topAnchor.constraint(equalTo: viewLabelNameAndViewStatus.topAnchor),
         labelName.bottomAnchor.constraint(equalTo: viewLabelNameAndViewStatus.bottomAnchor)].forEach{ $0.isActive = true }
    }
    
    func setupLabelStatusAndViewStatus() {
        viewLabelNameAndViewStatus.addSubview(viewStatus)
        viewStatus.translatesAutoresizingMaskIntoConstraints = false
        viewStatus.layer.cornerRadius = 12.5
        
        viewStatus.addSubview(labelStatus)
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.font = UIFont.systemFont(ofSize: 14)
        
        [viewStatus.heightAnchor.constraint(equalToConstant: 25),
         viewStatus.rightAnchor.constraint(equalTo: viewLabelNameAndViewStatus.rightAnchor),
         viewStatus.topAnchor.constraint(equalTo: viewLabelNameAndViewStatus.topAnchor),
         viewStatus.bottomAnchor.constraint(equalTo: viewLabelNameAndViewStatus.bottomAnchor)].forEach { $0.isActive = true }
        
        
        [labelStatus.topAnchor.constraint(equalTo: viewStatus.topAnchor, constant: 3),
         labelStatus.leftAnchor.constraint(equalTo: viewStatus.leftAnchor, constant: 10),
         labelStatus.rightAnchor.constraint(equalTo: viewStatus.rightAnchor, constant: -10),
         labelStatus.bottomAnchor.constraint(equalTo: viewStatus.bottomAnchor, constant: -3)].forEach { $0.isActive = true }
    }
    
    func setupLabelGenderAndRace() {
        stackViewAllInfoСharacter.addArrangedSubview(labelGenderAndRace)
        labelGenderAndRace.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setupButtonWatchEpisodes() {
        stackViewAllInfoСharacter.addArrangedSubview(buttonWatchEpisodes)
        buttonWatchEpisodes.translatesAutoresizingMaskIntoConstraints = false
        buttonWatchEpisodes.layer.cornerRadius = 17
        buttonWatchEpisodes.backgroundColor = UIColor(red: 255.0/255.0, green: 107.0/255.0, blue: 0.0, alpha: 0.1)
        buttonWatchEpisodes.setTitleColor(UIColor(red: 255, green: 107, blue: 0), for: .normal)
        buttonWatchEpisodes.setTitle("▶ Watch episodes", for: .normal)
        buttonWatchEpisodes.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        
        [buttonWatchEpisodes.heightAnchor.constraint(equalToConstant: 35),
         buttonWatchEpisodes.widthAnchor.constraint(equalToConstant: 148)].forEach { $0.isActive = true }
    }
    
    func setupImageViewVector() {
        stackViewImageViewVectorAndLabelPlanets.addArrangedSubview(imageViewVector)
        imageViewVector.translatesAutoresizingMaskIntoConstraints = false
        imageViewVector.image = UIImage(named: "Vector")
        
        [imageViewVector.widthAnchor.constraint(equalToConstant: 10),
         imageViewVector.heightAnchor.constraint(equalToConstant: 12)].forEach{ $0.isActive = true }
    }
    
    func setupLabelPlanets() {
        stackViewImageViewVectorAndLabelPlanets.addArrangedSubview(labelPlanets)
        labelPlanets.font = UIFont.systemFont(ofSize: 14)
    }
    
    func reloadData() {
        guard let responseResult = responseResult else {
            return
        }
        downloadPoster()
        labelName.text = responseResult.name
        labelStatus.text = responseResult.status
        labelGenderAndRace.text = "\(responseResult.species ?? ""), \(responseResult.gender?.lowercased() ?? "")"
        labelPlanets.text = responseResult.origin?.name
        
        let status = Status(rawValue: responseResult.status ?? "")
        labelStatus.text = status?.text
        labelStatus.textColor = status?.textColor
        viewStatus.backgroundColor = status?.backgroundColor
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
                        self?.posterImageView.image = UIImage(named:"play.slash")
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
        case unknow = "unknown"
        
        var text: String {
            switch self{
            case .alive:
                return "ALIVE"
            case .dead:
                return "DEAD"
            case .unknow:
                return "UNKNOWN"
            }
        }
        
        var backgroundColor: UIColor{
            switch self{
            case.alive:
                return UIColor(red: 199, green: 255, blue: 185)
            case.dead:
                return UIColor(red: 255, green: 232, blue: 224)
            case.unknow:
                return UIColor(red: 238, green: 238, blue: 238)
            }
        }
        
        var textColor: UIColor{
            switch self{
            case.alive:
                return UIColor(red: 49, green: 159, blue: 22)
            case.dead:
                return UIColor(red:233 , green: 56, blue: 0)
            case.unknow:
                return UIColor(red: 160, green: 160, blue: 160)
            }
        }
    }
    
    
}
