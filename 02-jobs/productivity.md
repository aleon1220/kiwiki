# Productivity & Hacks

## Gmail
### Filters
- Find unread emails without user added labels
```
is:unread -has:userlabels 
```

```
unread  `is:unread`
```
* exclude a particular label `is:unread -label:"TGIF Devotional"`

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