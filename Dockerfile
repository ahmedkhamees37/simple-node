# Backend
FROM openjdk:11-jre-slim as backend
WORKDIR /app
COPY backend/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

# Frontend
FROM nginx:alpine as frontend
COPY frontend/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]