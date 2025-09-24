import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        // Create a welcome label
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to Sample iOS App!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.textColor = .label
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a description label
        let descriptionLabel = UILabel()
        descriptionLabel.text = "This is a sample iOS application with Fastlane setup for CI/CD automation."
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a sample button
        let sampleButton = UIButton(type: .system)
        sampleButton.setTitle("Tap Me!", for: .normal)
        sampleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        sampleButton.backgroundColor = .systemBlue
        sampleButton.setTitleColor(.white, for: .normal)
        sampleButton.layer.cornerRadius = 8
        sampleButton.translatesAutoresizingMaskIntoConstraints = false
        sampleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Add subviews
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(sampleButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            welcomeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            sampleButton.widthAnchor.constraint(equalToConstant: 120),
            sampleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func buttonTapped() {
        let alert = UIAlertController(title: "Hello!", message: "Button was tapped successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}