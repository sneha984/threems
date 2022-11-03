class Listitems{
  final String img;
  final String text;
  final String amount;
  final  value;
  final String name;
  final String days;

  Listitems({required this.img,
    required this.value,
    required this.text,
    required this.amount,
    required this.name,
    required this.days});

}
class MultiSelect{
 final String image;
 final String payname;
   bool isSelected;
  MultiSelect({required this.image,required this.payname,required this.isSelected});
}