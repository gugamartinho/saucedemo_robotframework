FROM selenium/standalone-chrome

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir robotframework-pabot robotframework-seleniumlibrary

COPY . .

CMD ["pabot", "--variable", "HEADLESS:true", "--outputdir", "pabot_results", "tests"]
