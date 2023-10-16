## Terrahome AWS

```tf
module "home_forza" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.forza_public_path
  content_version = var.content_version
}
```

The public directory expects the following:
- index.html
- error.html
- assets

ALl top level files in assets will be copied, but not any subdirectories.