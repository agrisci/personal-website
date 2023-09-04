# My Personal Website

## Overview

This README provides an overview of the Personal Website project, including its architecture and key services used in its deployment. This project leverages various AWS services, Terraform for infrastructure provisioning, ReactJS for the frontend, and Jenkins for Continuous Integration/Continuous Deployment (CI/CD) purposes and Docker for the app containerization.

## Showcase

To access my Personal Website, simply navigate to the following URL:

Production: [https://atanopoulos.com](https://atanopoulos.com)

Development: [https://dev.atanopoulos.com](https://dev.atanopoulos.com)

### Project Architecture

The Personal Website project is hosted on AWS and takes advantage of several AWS services to ensure high availability and scalability. The architecture can be summarized as follows:

- **Route53**: Manages domain registration and DNS routing, allowing users to access the website via a custom domain name.

- **Application Load Balancer (ALB)**: Serves as the entry point for incoming traffic, distributing requests to the backend services running on AWS ECS.

- **Internet Gateway (IGW)**: Enables communication between the VPC and the internet, allowing users to access the website from anywhere.

- **Virtual Private Cloud (VPC)**: Provides a logically isolated network environment for the project's resources.

- **ECS (Elastic Container Service)**: Manages Docker container deployments and orchestrates them for high availability and scalability.

- **ECR (Elastic Container Registry)**: Stores Docker images used for the project's containerized applications.

- **IAM (Identity and Access Management)**: Manages permissions and access control to AWS resources for different services and users.

- **ACM (AWS Certificate Manager)**: Provides SSL/TLS certificates to secure communication between clients and the website.

- **EC2**: May be used for specific tasks or services that require traditional virtual machines within the VPC.

### Frontend Technologies

The frontend of the Personal Website is built using:

- **ReactJS**: A popular JavaScript library for building user interfaces, providing a responsive and dynamic user experience.

- **DaisyUI**: A UI component library for Tailwind CSS, enhancing the visual aesthetics and interactivity of the website.

### CI/CD Pipeline

Continuous Integration and Continuous Deployment (CI/CD) for the project are managed using Jenkins. The pipeline includes stages for both the "develop" and "prod" branches of the project:

- **Production and Development Branches**: Whenever changes are pushed to the "develop" or "main" branch, Jenkins automatically builds and deploys a new version of the website on AWS.

### Image Asset Generation

The project includes a Bash script that generates image assets during development on Fedora and Debian based distro's automatically. This script is triggered with pre-scripts defined in the package.json file. It helps automate the development and deployment process by creating necessary image assets as required.

## Conclusion

The Personal Website project utilizes a modern tech stack and cloud infrastructure to ensure a highly available, scalable, and secure web presence. With its CI/CD pipeline and automatic image asset generation, it streamlines development and ensures that your website remains up-to-date and accessible to your audience.

For detailed instructions on running or deploying the project, please refer to the project's specific documentation or reach out to the project maintainers.
