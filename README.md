# 🎓 Terraform Foundation for Teaching

Bem-vindo ao repositório **Terraform Foundation for Teaching**! 🚀

Este projeto tem como objetivo fortalecer a fundação e o ensino de infraestrutura como código (IaC) utilizando o **Terraform**. Ele foi desenhado para ser um ponto de partida simples e didático para o aprendizado e criação de recursos na AWS.

---

## 🛠️ Tecnologias Utilizadas

*   **Terraform** (>= 1.0) 🏗️
*   **AWS Provider** (v6.34.0) ☁️

---

## 📦 O que já foi construído?

Atualmente, o projeto provisiona e utiliza os seguintes recursos e conceitos:

*   **☁️ VPC (Rede):** 
    *   Criação de redes com um módulo local (`./modules/vpc`).
    *   Uso do módulo oficial da AWS (`terraform-aws-modules/vpc/aws`) para VPCs de ambientes (Non-Prod/Prod), incluindo sub-redes públicas e privadas.
*   **🪣 Armazenamento (S3):** 
    *   Módulo oficial da AWS (`terraform-aws-modules/s3-bucket/aws`) para provisionar um S3 Bucket com controles de acesso (Ownership) e versionamento ativado.
*   **🔐 Gestão de Estado Remoto:** 
    *   Configuração do Terraform Backend (`backend "s3"`) garantindo que o `terraform.tfstate` fique armazenado de forma segura na nuvem.
*   **🌍 Múltiplos Ambientes:** 
    *   Estrutura preparada para trabalhar com diversos ambientes usando variáveis e arquivos `.tfvars` (ex: `dev.tfvars`, `prod.tfvars`).
*   **🏷️ Padronização de Tags:** 
    *   Uso de atributos `locals` e `default_tags` no provider da AWS para facilitar a gestão da infraestrutura.

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

*   [Terraform](https://developer.hashicorp.com/terraform/downloads) 
*   [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configurado com suas credenciais.

---

## 🚀 Como Utilizar

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/terraform-foundation-for-teaching.git
    cd terraform-foundation-for-teaching
    ```

2.  **Inicialize o Terraform:**
    Este comando faz o download dos providers e inicializa o backend S3.
    ```bash
    terraform init
    ```

3.  **Verifique as mudanças (Plan) para um ambiente específico:**
    Exemplo para o ambiente de desenvolvimento:
    ```bash
    terraform plan -var-file="dev.tfvars"
    ```

4.  **Aplique a infraestrutura:**
    Crie os recursos na AWS (requer confirmação `yes`).
    ```bash
    terraform apply -var-file="dev.tfvars"
    ```

---

## 📜 Licença

Consulte o arquivo [LICENSE](./LICENSE) para mais detalhes.
