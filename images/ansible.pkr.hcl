variable "project_id" {
    type    = string
    default = "red-hat-mbu"
}

source "googlecompute" "ansible1" {
    project_id          = var.project_id
    source_image_family = "rhel-8"
    ssh_username        = "rhel"
    zone                = "us-east1-d"
    machine_type        = "n1-standard-2"
    image_name          = "ansible1"
}


build {
    sources = ["sources.googlecompute.ansible1"]

    provisioner "ansible1" {
        playbook_file = "./ansible/ansible-setup.yml"
        user = "rhel"
        extra_arguments = [ "-e", "@ansible/extra-vars.yml" ]
    }
}
