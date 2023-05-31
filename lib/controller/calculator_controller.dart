import '../model/calculator_model.dart';

enum Operation {add, subtract, multiply, divide}

class CalculatorController {
  final CalculatorModel _calculatorModel = CalculatorModel();

  void setNumber1(double number1) {
    _calculatorModel.number1 = number1;
  }

  void setNumber2(double number2) {
    _calculatorModel.number2 = number2;
  }

  double performOperation(Operation operation) {
    switch (operation) {
      case Operation.add:
        return _calculatorModel.number1 + _calculatorModel.number2;
      case Operation.subtract:
        return _calculatorModel.number1 - _calculatorModel.number2;
      case Operation.multiply:
        return _calculatorModel.number1 * _calculatorModel.number2;
      case Operation.divide:
        if (_calculatorModel.number2 != 0.0) {
          return _calculatorModel.number1 / _calculatorModel.number2;
        } else {
          throw Exception('Cannot divide by zero');
        }
      default:
        throw Exception('Invalid operation');
    }
  }
}
