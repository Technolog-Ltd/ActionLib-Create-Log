description = "Composite GitHub Action for generating structured version changelog entries from PR metadata."
visibility  = "public"

pro_features_enabled = false

repository_settings = {
  archive_on_destroy   = true
  vulnerability_alerts = false

  has = {
    issues   = true
    projects = true
  }

  allow = {
    merge_commit  = true
    squash_merge  = true
    rebase_merge  = true
  }
}

collaborators = {
  pull     = ["team:*"]
  push     = []
  maintain = ["Administrators"]
  admin    = []
}

features = {
  repository-control = {
    type                    = "gitflow"
    override_default_branch = "main"
  }
  pipeline-control = {
    default_branch = "main"
    pipeline_ref      = "v1.0.0"
  }
}

topics = ["github-actions", "composite-action", "changelog", "versioning", "ci-cd"]

tag_protections = {
  version_tags = {
    pattern = "v*"
  }
}

environments = {
  "technolog-pipeline-deploy" = {
    can_admins_bypass = true
  }
}

import_resources = {
  repository = "ActionLibrary-Create-Log"
}
