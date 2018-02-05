import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let CELL_NAME =                     "animal"
    private let SHOW_ANIMAL_SEGUE_IDENTIFIER =  "present"
    private let ICON_POSTFIX =                  "Icon"
    private let SOUND_POSTFIX =                 "Sound"

    private var animals = [String: [Animal]]()
    private var lastShown = [String: Int]()
    private var tappedAnimal: Animal?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerAnimalCell()
        initAnimals()
    }
    
    private func initAnimals() {
        let animalNames = ["Cat",  "Chimpanzee", "Cow",     "Dog",
                           "Duck", "Elephant",   "Girafee", "Horse",
                           "Lion", "Owl",        "Pig",     "Sheep"]
        animalNames.forEach { animal in
            animals[animal] = []
            lastShown[animal] = 0
            
            let icon = UIImage(named: animal+ICON_POSTFIX)
            for i in 1...5 {
                let image = UIImage(named: animal+String(i))!
                let sound = NSDataAsset(name: animal+String(i)+SOUND_POSTFIX)!.data
                animals[animal]!.append(Animal(name: animal, image: image, sound: sound, icon: icon!))
            }
        }
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        // if tapping on a cell, get the cell
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            let cell = self.collectionView?.cellForItem(at: indexPath) as! AnimalCollectionViewCell
            // get the cell's animal and show the animal
            tappedAnimal = cell.animal!
            self.performSegue(withIdentifier: SHOW_ANIMAL_SEGUE_IDENTIFIER, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Gets the next animal to be shown.
        func getAnimal() -> Animal {
            let animals = self.animals[tappedAnimal!.name]!
            
            // Get and update the index of the animal to shown.
            // Starts from 0 each time all animals have been shown.
            var indexOfAnimalToShow = lastShown[tappedAnimal!.name]!
            let max = animals.count - 1
            indexOfAnimalToShow = indexOfAnimalToShow >= max
                ? 0
                : indexOfAnimalToShow+1
            lastShown[tappedAnimal!.name] = indexOfAnimalToShow
            
            return animals[indexOfAnimalToShow]
        }
        
        if (segue.destination is AnimalViewController) {
            let viewController = segue.destination as! AnimalViewController
            viewController.animal = getAnimal()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_NAME, for: indexPath) as! AnimalCollectionViewCell
        cell.animal = animals[Array(animals.keys)[indexPath.row]]![0]
    
        let imageView = UIImageView(frame: cell.contentView.frame)
        imageView.image = cell.animal!.icon
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    /*
     Cells are registered programmatically because their size is set at runtime.
     */
    private func registerAnimalCell() {
        // Register cells programatically
        self.collectionView!.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: CELL_NAME)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height / 3)
    }
    
}
