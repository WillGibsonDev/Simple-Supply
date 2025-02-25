struct ProductCell: View {
    var product: Product
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(product.color.gradient)
                .frame(height: 250)
            VStack{
                Text(product.name)
                    .font(.title.bold())
            }
            .padding(50)
        }

    }
}