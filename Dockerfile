FROM eclipse-temurin:17-jre AS runtime
# For distroless, swap the above with:
# FROM gcr.io/distroless/java17-debian12

WORKDIR /app

# Copy only the final artifact(s)
# If you use Spring Boot, this will be your fat JAR in target/
COPY --from=build /app/target/*.jar app.jar

# Optional: non-root user (good security practice)
RUN useradd -r -u 1001 appuser
USER appuser

# Expose application port (adjust if not 8080)
EXPOSE 8080

# Health-friendly defaults
ENV JAVA_OPTS=""
ENV APP_OPTS=""

# Use exec form; pass tunable opts via env
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar $APP_OPTS"]
