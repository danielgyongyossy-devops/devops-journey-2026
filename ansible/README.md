# Ansible

Ansible is used here for day-2 operations around the Kubernetes clusters.

Terraform still owns cloud infrastructure. Helm still owns the app deployment. Ansible is for repeatable operational tasks like installing monitoring and checking that the app, pods, and HPA are healthy.

## Setup

```bash
cd ansible
ansible-galaxy collection install -r requirements.yml
```

## Install monitoring

Run this while your `kubectl` context points at the cluster you want to configure:

```bash
ansible-playbook playbooks/install-monitoring.yml
```

## Verify the app

```bash
ansible-playbook playbooks/verify-app.yml
```

If you want to check both GKE and EKS, switch context and run the same playbook again.
