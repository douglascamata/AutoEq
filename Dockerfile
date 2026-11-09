FROM ubuntu:22.04
RUN apt update
RUN apt install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt update
RUN apt -y install nodejs libsndfile1
COPY --from=ghcr.io/astral-sh/uv:0.13 /uv /uvx /bin/
ENV UV_PYTHON=3.11 UV_PYTHON_INSTALL_DIR=/opt/python UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy
WORKDIR /app
COPY ./autoeq/*.py ./autoeq/
COPY ./pyproject.toml ./pyproject.toml
COPY ./uv.lock ./uv.lock
COPY ./README.md ./README.md
RUN uv sync --locked --no-default-groups --group webapp --no-editable
COPY ./webapp/ui/package.json ./webapp/ui/package.json
COPY ./webapp/ui/package-lock.json ./webapp/ui/package-lock.json
COPY ./webapp/ui/public ./webapp/ui/public
COPY ./webapp/ui/src ./webapp/ui/src
COPY ./webapp/ui/config ./webapp/ui/config
COPY ./webapp/ui/scripts ./webapp/ui/scripts
COPY ./webapp/main.py ./webapp/main.py
WORKDIR /app/webapp/ui
RUN npm ci
RUN npm run build
WORKDIR /app/webapp
ENV APP_ENV=production PATH="/app/.venv/bin:$PATH"
CMD python -m uvicorn main:app --host 0.0.0.0 --port 8000
