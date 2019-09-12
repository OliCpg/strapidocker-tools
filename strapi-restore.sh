if [[ $# -eq 0 ]] ; then
    echo '⛔️ ERROR: Missing argument: please specify archive file.'
    exit 0
fi

archivename=$1
pattern=".tar.gz";
basedir=${archivename/$pattern/}

# Stopping docker container
# echo "Stopping containers..."
# docker stop strapi
# docker stop strapi_db
# echo "DONE"

# Deleting containers
echo "🔥  Deleting current conatainers"
docker rm -f strapi
docker rm -f strapi_db
echo "DONE"

# Recreating fresh containers
echo "🍺  Recreating fresh containers from compose file"
docker-compose up --no-start
echo "DONE"

# Unarchiving datas 
echo "🗃  Processing archived files..."
tar -xzf $1
echo "DONE"



# Restarting strapi to let it generate
# docker start strapi_db
# docker start strapi
docker-compose start

## wainting for api to be generated and ready
echo "⏳  waiting for api server to be generated"
strval1=$(curl --write-out %{http_code} --silent --output /dev/null localhost:8080)
while [ $strval1 != "200" ]
do 
    printf " [.   ]\r"
            sleep 1
            printf " [ .  ]\r"
            sleep 1
            printf " [  . ]\r"
            sleep 1
            printf " [   .]\r"
            sleep 1
            printf " [  . ]\r"
            sleep 1
            printf " [ .  ]\r"
            sleep 1
            printf " [.   ]\r"
            sleep 1
    strval1=$(curl --write-out %{http_code} --silent --output /dev/null localhost:8080)
done
    # docker stop strapi
    # docker stop strapi_db
    docker-compose stop

    echo "⏳  Stopping containers before injection..."
    sleep 10
    echo "DONE"

    #Injection of db files
    echo "💉  Injecting strapi DB..."
    docker cp -a ./$basedir/strapi-db/mysql strapi_db:/var/lib/
    echo "DONE"

    # Injection api files
    echo "💾  Injecting strapi api files..."
    docker cp -a ./$basedir/api/strapi-app strapi:/usr/src/api
    echo "DONE"

    #cleaning
    echo "🧹  Cleaning out..."
    # rm -r ./$basedir
    echo "DONE"

    echo "▶️  Restarting containers"
    # Starting docker container
    # docker start strapi_db
    # docker start strapi
    docker-compose start
    echo "DONE"


    #Final
    #echo "**** YOUR PROJECT DATA IS NOW RESTORED ! :-) ****"
