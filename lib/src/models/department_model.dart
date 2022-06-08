

class DepartmentModel{
  String deptName;
  int id;
  DepartmentModel(this.deptName,this.id);

  @override
  String toString() {
    return 'AdminModel{ID: $id, Department Name: $deptName}';
  }

  DepartmentModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? -999,
      deptName = parsedJson['deptName'] ?? "NO NAME FROM API";
}