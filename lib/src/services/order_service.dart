part of 'services.dart';

class OrderService {
  final ordersCollection =
      FirebaseFirestore.instance.collection(ordersCollectionName);

  Future<Either<String, List<OrderModel>>> fetchListOrder() async {
    try {
      String uid = await Commons().getUID();
      final querySnapshot =
          await ordersCollection.where('uid', isEqualTo: uid).get();
      final data =
          querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, OrderModel>> fetchDetailOrder(String docId) async {
    try {
      final documentSnapshot = await ordersCollection.doc(docId).get();

      final data = OrderModel.fromMap(documentSnapshot.data()!);
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> orderProcess(OrderModel model) async {
    try {
      await ordersCollection.doc(model.id).set(model.toMap());

      return right('Berhasil Melakukan Checkout');
    } catch (e) {
      return left(e.toString());
    }
  }
}
