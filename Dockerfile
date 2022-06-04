FROM public.ecr.aws/lambda/python:3.9 as base

# build container
FROM base AS build
ARG FURY_URL="https://pypi.org/simple/"
ARG HANDLER="handler.handler"

# install build tools
RUN yum groupinstall -q -y "Development Tools"

# install poetry
RUN pip install poetry

# copy project files
COPY poetry.lock .
COPY pyproject.toml .
COPY src/pylambda/ ${LAMBDA_TASK_ROOT}
COPY README.md .

# install runtime deps
RUN poetry export --without-hashes -f requirements.txt --output requirements.txt
RUN pip3 install \
    --index-url "${FURY_URL}" \
    --extra-index-url https://pypi.org/simple/ \
    -r requirements.txt \
    --target "${LAMBDA_TASK_ROOT}"

#runtime container
FROM base

# args
ARG HANDLER="handler.handler"
ENV HANDLER="${HANDLER}"

# use custom entrypoint so we have dynamic handler control in CMD call
COPY bin/custom_entrypoint.sh /custom_entrypoint.sh
RUN chmod a+rx /custom_entrypoint.sh

WORKDIR "${LAMBDA_TASK_ROOT}"
COPY --from=build ${LAMBDA_TASK_ROOT} ${LAMBDA_TASK_ROOT}

ENTRYPOINT [ "/custom_entrypoint.sh"  ]
CMD [ "${HANDLER}" ]
