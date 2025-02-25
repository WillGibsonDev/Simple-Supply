@Model
class Product {
    var name: String // Unique attribute for identification
    var materialsUsed: [ProductMaterial]
    var color: Color { return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }

    init(name: String, materialsUsed: [ProductMaterial]) {
        self.name = name
        self.materialsUsed = materialsUsed
    }
}