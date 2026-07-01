# Productivity & Hacks

## Gmail

### Filters

#### Find unread emails without user added labels

```text
is:unread -has:userlabels 
```

#### find unread emails

```text
unread  `is:unread`
```

#### unread emails exclude a label

```text
is:unread -label:"TGIF Devotional"
```

#### emails between a 3 month period

```text
label:email-history-2020  after:2020/1/01 before:2020/4/1
```

## Outlook

### filter emails with no categories in Outlook

save the view in outlook.

1. Open Outlook and go to your inbox.
2. Click on the "View" tab in the ribbon at the top of the screen.
3. Select "View Settings" (or "Current View" and then "View Settings" in some versions).
4. In the "Advanced View Settings" dialog box, click on "Filter".
5. In the "Filter" dialog box, go to the "Advanced" tab.
6. Click on "Field", then choose "All Mail Fields" and select "Categories".
7. Set the condition to "is empty"
8. Click "Add to List" and then "OK" to apply the filter.

Outlook Filter flagged items to do

```powershell
followupflag:followup flag category:="Client-"
```

- Find uncategorized email use `category:=[]` in the search bar

## Productivity tools

Includes time management, pomodoro techniques, focus tools

## Time Management

### Rescue time Reports

#### productivity Month

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

## Pomodoro technique

set a time for 30 mins and focus on achieving a task to get started.

## focus tools

## WorkLog analysis Tool

i came up with the idea of taking notes of what i did daily. I use a markdown structure created with a java program.
at the end of the month i upload the compiled log and let AI analyse it for me.

### Process

1. merge all Markdown files

    ```bash
    cat *.md > "$(date +%F)-MonthAnalysis.md"
    ```

2. Run some prompts to extract an analysis
3. Reflect and list action items
4. refer to [retrospective-reflection tools](https://github.com/aleon1220/AI-prompts/tree/main/retrospectives)

## Forums ICT

### Spinnaker Stack Overflow no answers

[StackOVerflow Spinnaker](https://stackoverflow.com/questions/tagged/spinnaker?sort=MostVotes&filters=NoAnswers&edited=true)
