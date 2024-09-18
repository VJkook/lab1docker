$ContainerName = "test-container"
$OldContainerName = "${ContainerName}-old"
$ImageName = "test-app"
$Tag = "latest"
$OldTag = "old-latest"
$PortMapping = "3000:3000"

# Остановка и удаление старого контейнера (если он существует)
docker stop $ContainerName -ErrorAction SilentlyContinue
docker rm $ContainerName -ErrorAction SilentlyContinue

# Тегирование старого образа (если существует)
docker tag "${ImageName}:${Tag}" "${ImageName}:${OldTag}" 

# Создание нового образа
docker build -t "${ImageName}:${Tag}" .

# Запуск нового контейнера с портом
docker run -d --name $ContainerName -p $PortMapping "${ImageName}:${Tag}"

# Запуск старого контейнера с предыдущим тегом и портом
docker run -d --name $OldContainerName -p $PortMapping "${ImageName}:${OldTag}"
