import 'package:readaton/state/state.dart';

class PickImportBooksStepAction {
  final int newStep;

  const PickImportBooksStepAction(this.newStep);
}

class StartLoadingShelvesAction {
  const StartLoadingShelvesAction();
}

class AddGoodreadsShelvesAction {
  final List<GoodreadsShelf> newShelves;

  const AddGoodreadsShelvesAction(this.newShelves);
}

class SelectShelfForImportAction {
  final int shelfId;

  const SelectShelfForImportAction(this.shelfId);
}

class DeselectShelfForImportAction {
  final int shelfId;

  const DeselectShelfForImportAction(this.shelfId);
}