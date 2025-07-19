terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.6.0"
    }
  }
}

provider "render" {
  api_key = var.RENDER_API_KEY
  owner_id = var.OWNER_ID
}

resource "render_web_service" "backend" {
  name   = "testing-dev-backend"
  plan   = "starter"
  region = "oregon"

  env_vars = {
    PORT = {
      value = "5000"
    }
    DATABASE_URL = {
      value = var.DATABASE_URL
    }
  }

  root_directory = "backend"

  runtime_source = {
    docker = {
      dockerfile_path = "./Dockerfile"
      repo_url        = var.repo_url
      branch          = var.repo_branch
      auto_deploy     = true
    }
  }
}

resource "render_web_service" "frontend" {
  name   = "testing-dev-frontend"
  plan   = "starter"
  region = "oregon"

  env_vars = {
    PORT = {
      value = "5001"
    }
    VITE_BACKEND_URL = {
      value = "https://testing-devops-backend-c9q7.onrender.com"
    }
  }

  root_directory = "frontend"

  runtime_source = {
    docker = {
      dockerfile_path = "./Dockerfile"
      repo_url        = var.repo_url
      branch          = var.repo_branch
      auto_deploy     = true
    }
  }
}