FROM python:3
WORKDIR .
COPY requirements.txt ./
ADD app.py /
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python", "./app.py" ]