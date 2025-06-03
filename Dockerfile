# Dockerfile
FROM denoland/deno:1.38.5

EXPOSE 1667

WORKDIR /app

# Копируем файлы
COPY . .

# Указываем разрешения
RUN deno cache src/app.ts

CMD ["run", "--allow-net", "--allow-read", "--allow-env", "--allow-write", "src/app.ts"]
