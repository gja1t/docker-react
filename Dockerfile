FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

# Install all of our dependencies
RUN npm install

COPY . .

RUN npm run build
# Production assets will be in: /app/build 
# Need to copy over during run phase


# Second FROM statement means new phase (first phase is called "builder"
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Nothing needed to start nginx because is already in base nginx container
