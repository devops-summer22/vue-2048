FROM node:latest AS builder
WORKDIR /build
COPY package.json yarn.lock ./
RUN yarn install
COPY ./ ./
RUN yarn build

FROM httpd AS runtime
COPY --from=builder /build/dist/ /usr/local/apache2/htdocs/
# Or, using nginx:
# FROM nginx
# COPY --from=builder /build/dist/ /usr/share/nginx/html/
