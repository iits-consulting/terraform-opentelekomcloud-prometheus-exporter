data "opentelekomcloud_identity_project_v3" "current" {}

resource "opentelekomcloud_identity_user_v3" "user" {
  name        = "${var.name_prefix}-prom"
  description = "CES read only access programmatic user for ${var.release_name}."
  enabled     = true
}

data "opentelekomcloud_identity_role_v3" "ces_role" {
  name = "system_all_60" #CES ReadOnly Role
}

resource "opentelekomcloud_identity_group_v3" "ces_group" {
  name        = "${var.name_prefix}-prom"
  description = "CES read only access group for ${var.release_name}."
}

resource "opentelekomcloud_identity_role_assignment_v3" "ces_role_to_ces_group" {
  group_id   = opentelekomcloud_identity_group_v3.ces_group.id
  role_id    = data.opentelekomcloud_identity_role_v3.ces_role.id
  project_id = data.opentelekomcloud_identity_project_v3.current.id
  lifecycle {
    ignore_changes = [project_id]
  }
}

resource "opentelekomcloud_identity_group_membership_v3" "user_to_ces_group" {
  group = opentelekomcloud_identity_group_v3.ces_group.id
  users = [opentelekomcloud_identity_user_v3.user.id]
}

resource "opentelekomcloud_identity_credential_v3" "user_aksk" {
  user_id     = opentelekomcloud_identity_user_v3.user.id
  description = "CES read only user for ${var.release_name}."
  depends_on  = [opentelekomcloud_identity_group_membership_v3.user_to_ces_group]
}
