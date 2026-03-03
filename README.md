# 🎓 Terraform Foundation for Teaching

Bem-vindo ao repositório **Terraform Foundation for Teaching**! 🚀

Este projeto tem como objetivo fortalecer a fundação e o ensino de infraestrutura como código (IaC) utilizando o **Terraform**. Ele foi desenhado para ser um ponto de partida simples e didático para o aprendizado e criação de recursos na AWS.

---

## 🛠️ Tecnologias Utilizadas

*   **Terraform** (>= 1.0) 🏗️
*   **AWS Provider** (v6.34.0) ☁️

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
    Este comando faz o download dos providers necessários (como o provider da AWS).
    ```bash
    terraform init
    ```

3.  **Verifique as mudanças (Plan):**
    Veja o que será criado ou alterado na sua infraestrutura.
    ```bash
    terraform plan
    ```

4.  **Aplique a infraestrutura:**
    Crie os recursos na AWS (requer confirmação `yes`).
    ```bash
    terraform apply
    ```

---

## 📜 Licença

Consulte o arquivo [LICENSE](./LICENSE) para mais detalhes.
