echo "Begin deploy" &&
git checkout release && 
git merge master --no-edit && 
rake assets:precompile && 
git add . && 
git commit -m "release" &&
heroku maintenance:on &&
git push heroku release:master &&
heroku run rake db:migrate &&
heroku maintenance:off &&
git checkout master &&
echo "Finished"
