#backup directory creation based on current date
basedir=`date '+%m_%d_%Y-%H_%M'`
mkdir ./$basedir;

# Stopping docker container
echo "⏹  Stopping containers..."
docker stop strapi
docker stop strapi_db
echo "DONE"

#API Files
echo "💾  Copying strapi api files..."
docker cp -a strapi:/usr/src/api ./$basedir
rm -r ./$basedir/api/strapi-app/node_modules
echo "DONE"

#API DB
echo "🛢  Copying strapi DB..."
mkdir ./$basedir/strapi-db
docker cp -a strapi_db:/var/lib/mysql ./$basedir/strapi-db
echo "DONE"

echo "▶️  Restarting containers"
# Stopping docker container
docker start strapi
docker start strapi_db
echo "DONE"

#Zipping it up
echo "🗜  Creating archive ($basedir.tar.gz)..."
tar -zcf $basedir.tar.gz $basedir/
rm -r $basedir
echo "DONE"

#FINAL ECHO
echo "**** 🥳  YOUR PROJECT DATA IS NOW SAFE ! 🥳 ****"
