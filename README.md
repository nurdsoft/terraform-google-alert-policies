# terraform-google-alert-policies

A Terraform module for creating GCP Monitoring alert policies for Cloud Run and Cloud SQL resources.

## Features

- Pre-configured alert policies for common scenarios
- Cloud Run high request rate monitoring
- Cloud Run error log spike detection
- Cloud SQL CPU utilization alerts
- Cloud SQL disk utilization alerts
- Configurable thresholds and durations
- Support for multiple notification channels

---

## Assumptions

The project assumes the following:

- A basic understanding of [Git](https://git-scm.com/).
- Git version `>= 2.33.0`.
- An existing GCP IAM user or role with access to create/update/delete resources defined in [main.tf](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/main.tf).
- [GCloud CLI](https://cloud.google.com/sdk/docs/install) `>= 465.0.0`.
- A basic understanding of [Terraform](https://www.terraform.io/).
- Terraform version `>= 1.3.0`.
- (Optional - for local testing) A basic understanding of [Make](https://www.gnu.org/software/make/manual/make.html#Introduction).
  - Make version `>= GNU Make 3.81`.
  - **Important Note**: This project includes a [Makefile](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/Makefile) to speed up local development in Terraform. The `make` targets act as a wrapper around Terraform commands. As such, `make` has only been tested/verified on **Linux/Mac OS**. Though, it is possible to [install make using Chocolatey](https://community.chocolatey.org/packages/make), we **do not** guarantee this approach as it has not been tested/verified. You may use the commands in the [Makefile](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/Makefile) as a guide to run each Terraform command locally on Windows.

---

## Test

**Important Note**: This project includes a [Makefile](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/Makefile) to speed up local development in Terraform. The `make` targets act as a wrapper around Terraform commands. As such, `make` has only been tested/verified on **Linux/Mac OS**. Though, it is possible to [install make using Chocolatey](https://community.chocolatey.org/packages/make), we **do not** guarantee this approach as it has not been tested/verified. You may use the commands in the [Makefile](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/Makefile) as a guide to run each Terraform command locally on Windows.

```sh
gcloud init # https://cloud.google.com/docs/authentication/gcloud
gcloud auth application-default login

# Copy the example tfvars and customize it
cp examples/simple/examples.tfvars examples/simple/terraform.tfvars
# Edit terraform.tfvars with your values

# Run terraform commands
make plan SVC=simple
make apply SVC=simple
make destroy SVC=simple
```

---

## Contributions

Contributions are always welcome. As such, this project uses the `main` branch as the source of truth to track changes.

**Step 1**. Clone this project.

```sh
# Using SSH
$ git clone git@github.com:nurdsoft/terraform-google-alert-policies.git

# Using HTTPS
$ git clone https://github.com/nurdsoft/terraform-google-alert-policies.git
```

**Step 2**. Checkout a feature branch: `git checkout -b feature/abc`.

**Step 3**. Validate the change/s locally by executing the steps defined under [Test](#test).

**Step 4**. If testing is successful, commit and push the new change/s to the remote.

```sh
$ git add file1 file2 ...

$ git commit -m "Adding some change"

$ git push --set-upstream origin feature/abc
```

**Step 5**. Once pushed, create a [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) and assign it to a member for review.

- **Important Note**: It can be helpful to attach the `terraform plan` output in the PR.

**Step 6**. A team member reviews/approves/merges the change/s.

**Step 7**. Once merged, deploy the required changes as needed.

**Step 8**. Once deployed, verify that the changes have been deployed.

- If possible, please add a `plan` output using the feature branch so the member reviewing the PR has better visibility into the changes.

---

## Usage

```hcl
module "alert_policies" {
  source = "git::https://github.com/nurdsoft/terraform-google-alert-policies.git?ref=main"

  notification_channels = ["projects/my-project/notificationChannels/12345"]
  alert_services_regex  = "service-a|service-b|service-c"

  high_request_alert_display_name = "Cloud Run - High Request Rate Alert"
  error_alert_display_name        = "Cloud Run - Error Log Spike Alert"
  cpu_alert_display_name          = "Cloud SQL - High CPU Utilization Alert"
  disk_alert_display_name         = "Cloud SQL - High Disk Utilization Alert"
}
```

## Alert Policies

The module provisions the following 4 alert policies:

| # | Name | Resource | Condition | Severity | Default Threshold |
|---|------|----------|-----------|----------|-------------------|
| 1 | High Request Rate | Cloud Run | Request rate exceeds threshold | WARNING | 10 req/s for 60s |
| 2 | Error Log Spike | Cloud Run | ERROR log count exceeds threshold | ERROR | > 1 in 60s |
| 3 | CPU Utilization | Cloud SQL | CPU utilization exceeds threshold | WARNING | > 75% |
| 4 | Disk Utilization | Cloud SQL | Disk utilization exceeds threshold | WARNING | > 50% |

## Examples

| Example | Description |
|---|---|
| [simple](./examples/simple) | Create alert policies for Cloud Run and Cloud SQL monitoring |

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.3 |
| google | >= 5.0 |

## Providers

| Name | Version |
|---|---|
| [google](https://registry.terraform.io/providers/hashicorp/google/latest) | >= 5.0 |

## Inputs

### Required

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `notification_channels` | List of notification channel IDs to send alerts to | `list(string)` | n/a | yes |
| `alert_services_regex` | Regex pattern to match Cloud Run service names | `string` | n/a | yes |
| `high_request_alert_display_name` | Display name for Cloud Run high traffic alert | `string` | n/a | yes |
| `error_alert_display_name` | Display name for Cloud Run error alert | `string` | n/a | yes |
| `cpu_alert_display_name` | Display name for Cloud SQL CPU alert | `string` | n/a | yes |
| `disk_alert_display_name` | Display name for Cloud SQL disk alert | `string` | n/a | yes |

### Optional

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `high_request_threshold` | Request rate threshold in requests per second | `number` | `10` | no |
| `high_request_duration` | Duration for high request threshold | `string` | `"60s"` | no |
| `error_threshold` | Error count threshold | `number` | `1` | no |
| `error_duration` | Duration for error threshold | `string` | `"0s"` | no |
| `cpu_threshold` | CPU utilization threshold (0.0-1.0) | `number` | `0.75` | no |
| `cpu_duration` | Duration for CPU threshold | `string` | `"0s"` | no |
| `disk_threshold` | Disk utilization threshold (0.0-1.0) | `number` | `0.50` | no |
| `disk_duration` | Duration for disk threshold | `string` | `"0s"` | no |

## Outputs

| Name | Description |
|---|---|
| `alert_policy_ids` | Map of alert policy keys to their GCP resource IDs |
| `alert_policy_names` | Map of alert policy keys to their GCP resource names |

### Alert Policy Output Keys

| Key | Alert Policy |
|---|---|
| `cloud_run_high_traffic` | Cloud Run High Request Rate |
| `cloud_run_error_alert` | Cloud Run Error Log Spike |
| `cloud_sql_cpu_alert` | Cloud SQL CPU Utilization |
| `cloud_sql_disk_alert` | Cloud SQL Disk Utilization |

## Authors

Module is maintained by [Nurdsoft](https://github.com/nurdsoft).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/nurdsoft/terraform-google-alert-policies/blob/main/LICENSE) for full details.
