class PhotoFoodModel {
  //create Field
  int id;
  String category, nameFood, price, detail, imagePath, nameReview, scoreReview;

  //Constructor
  PhotoFoodModel._({this.id,this.category,
                  this.nameFood,
                  this.price,
                  this.detail ,
                  this.imagePath,
                  this.nameReview,
                  this.scoreReview}
                  );
  
   factory PhotoFoodModel.fromJson(Map<String ,dynamic> parseJSON){
    return new PhotoFoodModel._(
                              id: int.parse(parseJSON['id']),
                              category: parseJSON['Category'],
                              nameFood: parseJSON['NameFood'],
                              price: parseJSON['Price'],
                              detail: parseJSON['Detail'],
                              imagePath: parseJSON['ImagePath'],
                              nameReview: parseJSON['NameReview'],
                              scoreReview: parseJSON['ScoreReview']
    );
  }

}
