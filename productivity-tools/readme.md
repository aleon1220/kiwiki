# Productivity tools
Includes time management, pomodoro techniques, focus tools, soft skills, news, etc.

# Rescue time

## Reports
### productivity Month
```bash
Current_month=$(date +%Y-%m-01)

echo "https://www.rescuetime.com/browse/productivity/daily_patterns/for/the/month/of/$Current_month"
```
[Example Month October 2020](https://www.rescuetime.com/browse/productivity/daily_patterns/for/the/month/of/2020-10-01)

## Integrations
#### Set up a git post-commit to add highlights (Ubuntu)
- Edit `~/.bashrc`
`vim ~/.bashrc`
- Add the `API_KEY` secret
```bash
## RescueTime integration
export RESCUE_TIME_API_KEY="<Add your API key>"
```
- Load the configs from `bashrc` file
`source ~/.bashrc`
- Copy the `post-commit` script to your destination git repo. It must be located in `YOUR_GIT_REPO/.git/hooks`

## Forums ICT
### Spinnaker Stack Overflow no answers
[StackOVerflow Spinnaker](https://stackoverflow.com/questions/tagged/spinnaker?sort=MostVotes&filters=NoAnswers&edited=true)

[Back to top](#)