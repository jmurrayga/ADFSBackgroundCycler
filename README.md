# ADFSBackgroundCycler
Active Directory Federated Services Background Cycler

The cycler updates the background image of the ADFS web page.

This can cycle through multiple pictures in a single directory or it can cycle through pictures in multiple directories based on the given season.

# Install

1. Download repository and save to a directory.
2. Setup local service account with access to the directory and ADFS service.
3. Import UpdateADFSLoginPage.xml or create a scheduled task to execute UpdateADFS.ps1 on a given interval (5 minute recommended).
4. Set CurrentTheme.txt to Seasonal or override to "Generic/Winter/Summer/Spring/Fall".

Generic is entered in CurrentTheme.txt by default. 

Note: Any folder added to the root folder of the application can be added to CurrentTheme.txt.
