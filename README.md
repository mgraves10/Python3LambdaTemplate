# New Lambda
Tell me about your lambda.

## Setup
Configure Private Repository Credentials (assumes gemfury)
```
poetry config repositories.gemfury "https://pypi.fury.io/${FURY_ORG}/"
poetry config http-basic.gemfury "${FURY_AUTH}" "${FURY_AUTH}"
```
Install project
```
poetry install
```
Update dependencies
```
poetry update
```
Install pre-commit dependencies
```
poetry run pre-commit install
```

## Tests
Running Tests
```
poetry run pytest
```

## Packaging
### Container
```
docker build --build-arg FURY_URL="${FURY_URL}" -t pylambda:latest .
```
Running the container locally:
```
docker run -p 9000:8080 pylambda:latest
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"data": "test"}'
```

### Wheel
```
poetry build -f wheel
```

### Zip Archive
```
poetry build -f wheel
poetry run pip install --upgrade -t dist/zip dist/*.whl
cd dist/zip
zip -r ../lambda.zip . -x '*.pyc'
cd -
```

## Contributing
Ensure all pre-commit hooks are passing before creating a pull request.
```
poetry run pre-commit install
poetry run pre-commit run --all-files
```
