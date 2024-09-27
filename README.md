# Desafio JackExperts: Aplicação com Página HTML Customizável em Kubernetes

## Descrição do Projeto

Este projeto é uma aplicação simples com uma página HTML customizável, definida via Helm e hospedada em um cluster Kubernetes. O desafio envolve a criação de uma pipeline CI/CD, construção de imagem Docker, configuração de recursos Kubernetes via Helm e deploy automatizado em um cluster Kubernetes.

## Tecnologias Utilizadas

- **Docker**: Para containerização da aplicação.
- **Kubernetes**: Para orquestração de contêineres.
- **Helm**: Para gerenciamento de pacotes Kubernetes.
- **GitHub Actions**: Para automação do pipeline CI/CD.
- **ConfigMap**: Para configuração dinâmica da página HTML.
- **Ingress**: Para configuração de domínio de acesso.

## Estrutura do Repositório

```bash
├── .github/
│   └── workflows/
│       └── deploy.yaml  # Pipeline CI/CD
├── helm-chart/
│   ├── templates/
│   │   ├── configmap.yaml  # Configuração do HTML via ConfigMap
│   │   ├── deployment.yaml  # Deployment da aplicação
│   │   ├── service.yaml  # Exposição da aplicação como Service
│   │   └── ingress.yaml  # Configuração do Ingress
│   └── Chart.yaml  # Definição do Helm Chart
├── Dockerfile  # Definição da imagem Docker
├── README.md  # Documentação do projeto
└── index.html  # Página HTML customizável
```

## Pré-requisitos

- Cluster Kubernetes configurado.
- Conta no Docker Hub.
- Kubectl e Helm instalados e configurados localmente.
- GitHub para versionamento e execução da pipeline.

## Passos para Configuração

### 1. Clonar o Repositório

```bash
git clone https://github.com/seu-usuario/nome-do-repositorio.git
cd nome-do-repositorio
```

### 2. Construir e Publicar a Imagem Docker

```bash
docker build -t seu-usuario/nome-da-imagem .
docker push seu-usuario/nome-da-imagem
```

### 3. Modificar o Helm Chart

No diretório `helm-chart/templates`, você pode ajustar a página HTML no arquivo `configmap.yaml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: html-config
  labels:
    desafio: jackexperts
data:
  index.html: |
    <html>
    <body>
      <h1>Bem-vindo ao Desafio JackExperts</h1>
    </body>
    </html>
```

### 4. Configurar o Cluster Kubernetes

Instale o Helm Chart no cluster:

```bash
helm upgrade --install nome-da-aplicacao ./helm-chart --set image.repository=seu-usuario/nome-da-imagem --set image.tag=latest
```

### 5. Acessar a Aplicação

Configure um Ingress no seu cluster para acessar a aplicação via domínio. O domínio pode ser configurado no arquivo `ingress.yaml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: desafio-ingress
  labels:
    desafio: jackexperts
spec:
  rules:
    - host: seu-dominio.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: desafio-service
                port:
                  number: 80
```

### 6. Pipeline CI/CD com GitHub Actions

O arquivo `deploy.yaml` configura a pipeline CI/CD, realizando o build da imagem, push para o Docker Hub e deploy no cluster Kubernetes.

#### Configurar Secrets no GitHub

Para que o pipeline funcione, é necessário configurar os seguintes **secrets** no repositório:

- **DOCKER_USERNAME**: Seu usuário do Docker Hub.
- **DOCKER_PASSWORD**: Senha do Docker Hub.
- **KUBECONFIG**: Arquivo de configuração do Kubernetes para conectar ao cluster.

#### Como Funciona o Pipeline

- O pipeline é acionado em push para a branch `main`.
- Ele constrói a imagem Docker, faz o push para o Docker Hub e realiza o deploy da aplicação no cluster Kubernetes via Helm.

### 7. Testar a Aplicação

Após o deploy, acesse o domínio configurado para verificar a página HTML customizável.

## Estrutura do Helm Chart

- **configmap.yaml**: Configuração da página HTML.
- **deployment.yaml**: Define o Deployment que gerencia os pods da aplicação.
- **service.yaml**: Exposição da aplicação como um Service.
- **ingress.yaml**: Configura o Ingress para acessar a aplicação via domínio.

## Labels de Identificação

Todos os objetos Kubernetes gerados pelo Helm Chart possuem a label `desafio=jackexperts`, como exigido pelo desafio.

## Conclusão

Este projeto implementa uma aplicação simples em Kubernetes com um pipeline CI/CD completo, que realiza o build, push e deploy automaticamente em cada atualização de código. A página HTML é customizável via ConfigMap, e a aplicação pode ser acessada via um domínio configurado no Ingress.

---

**Autor:** Lucas Paiva Cidral de Oliveira  
**Repositório GitHub:** [Link para o repositório]((https://github.com/lucaspco/desafioJackExperts))
