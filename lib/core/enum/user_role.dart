enum UserRole { father, mother, child }

UserRole getRoleFromString(String role) {
  switch (role.toLowerCase()) {
    case 'father':
      return UserRole.father;
    case 'mother':
      return UserRole.mother;
    case 'child':
      return UserRole.child;
    default:
      throw Exception('Unknown role');
  }
}

String roleToString(UserRole role) {
  return role.name;
}
