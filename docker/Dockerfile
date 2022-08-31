FROM FROM_IMAGE_NAME as init

ARG SERVICE_NAME

ARG STAGE

ARG AWS_REGION

ARG AWS_ACCESS_KEY_ID

ARG AWS_SECRET_ACCESS_KEY

ARG AWS_SESSION_TOKEN

ARG CONTAINER_WORDIR

FROM node:16 as processing

ARG SERVICE_NAME

ARG STAGE

ARG AWS_REGION

ARG AWS_ACCESS_KEY_ID

ARG AWS_SECRET_ACCESS_KEY

ARG AWS_SESSION_TOKEN

ARG CONTAINER_WORDIR

ENV AWS_REGION=${AWS_REGION}

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}

ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

ENV AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}

ENV STAGE=${STAGE}

ENV SERVICE_NAME=${SERVICE_NAME}

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip

RUN ./aws/install

RUN mkdir -p /app

WORKDIR /app

COPY --from=init ${CONTAINER_WORDIR} .

RUN pwd

RUN find /app -type f -name '*.js' -not -name '*.js.map' -not -path "/app/node_modules/*" -exec sed -i -e "s#sourceMappingURL=#sourceMappingURL=https://lendis-eks-source-maps.s3.us-east-1.amazonaws.com/${SERVICE_NAME}/${STAGE}/#g" "{}" \;

RUN rm -rf /app/**/*.js-e

RUN aws s3  mv /app s3://lendis-eks-source-maps/${SERVICE_NAME}/${STAGE}/ --recursive --exclude "*.js" --exclude "node_modules/*" --region ${AWS_REGION}

RUN rm -rf /app/**/*.js.map

FROM FROM_IMAGE_NAME

ARG CONTAINER_WORDIR

COPY --from=processing /app ${CONTAINER_WORDIR}