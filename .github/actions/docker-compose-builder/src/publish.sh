PROFILES="$1"
COMPOSE_FILES="$2"
REPO_TOKEN="$3"
GITHUB_REPOSITORY=$(echo "$GITHUB_REPOSITORY" | awk '{print tolower($0)}')

echo "PROFILES=$PROFILES"
echo "COMPOSE_FILES=$COMPOSE_FILES"

docker login ghcr.io -u "${GITHUB_REF}" -p "${REPO_TOKEN}"

docker-compose "$COMPOSE_FILES" "$PROFILES" build
docker-compose "$COMPOSE_FILES" "$PROFILES" push
#IMAGES=$(docker inspect --format='{{.Image}}' "$(docker compose ps -aq)")

#echo "IMAGES: $IMAGES"
#for IMAGE in $IMAGES; do
#    echo "IMAGE: $IMAGE"
#
#    NAME=$(basename "${GITHUB_REPOSITORY}").$(docker inspect --format '{{ index .Config.Labels "name" }}' "$IMAGE")
#    TAG="ghcr.io/${GITHUB_REPOSITORY}/$NAME:$VERSION"
#
#    docker tag "$IMAGE" "$TAG"
#    docker push "$TAG"
#done
