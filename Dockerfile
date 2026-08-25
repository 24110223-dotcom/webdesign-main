# Giai đoạn 1: Build file WAR bằng Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy trên Tomcat
FROM tomcat:10-jdk17
# Xóa các ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file WAR được build từ giai đoạn 1 vào thư mục webapps và đổi tên thành ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]