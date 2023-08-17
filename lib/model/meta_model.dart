import 'package:equatable/equatable.dart';

class MetaModel extends Equatable {
  final int page;
  final int pages;
  final int pageSize;
  final int records;

  const MetaModel({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  const MetaModel.empty()
      : this(
          page: 0,
          pages: 0,
          pageSize: 0,
          records: 0,
        );

  @override
  List<Object?> get props => [
        page,
        pages,
        pageSize,
        records,
      ];
}
