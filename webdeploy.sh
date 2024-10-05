echo "Pulling latest changes from Git..."
git pull

echo "Building Flutter web project..."
flutter build web

echo "Navigating to build/web directory..."
cd build/web

echo "Serving the project on localhost at port 8080..."
serve -l 8080
