# TFS: Smoke Test

## 1. Install New Policy

* Uninstall any existing V1 Policy.
* Run the vsix.
* Expect: Success
* Expect: Extensions shows VersionOneTFSPolicy

## 2. Install New Listener

* Uninstall any existing V1 Listener.
* Run the installer.
* Accept default port.
* Expect: Success
* Open IIS Manager -> Handler Mappings
* Expect: all the svc entries are mapped
  * If not:
  * Enable Windows Communcation Foundation HTTP Activation
  * Set application pool to .NET 4.0
  * If not, run `C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -i`
* Open http://localhost:9090/service.svc
* Expect: "You have created a service"

## 3. Configure VersionOne Connection

* Run Configuration Tool
* Provide VersionOne URL and credentials
* Test Connetion
* Expect: Success

## 4. Configure TFS

* Provide TFS URL and credentials
* Connect
* Expect: Connected to ...

## 5. Create a Story

* Open VersionOne.
* Create a new story.
* Select current sprint.
* Open asset tray.
* Open the new story.

## 6. Check-in Code

* Open Visual Studio
* Team -> Conect to TFS -> Choose your server
* Open Team -> Team Project Settings -> Source Control...
* Select Check-in Policy
* Expect: VersionOne Policy is enabled.
* Open Source Code Explorer
* Open source code file (use workspace version, if prompted)
* Make a change.
* Select Pending Changes.
* Expect: Policy dialog
* Expect: My Items has stuff
* Expect: All Items has stuff
* Find the new story from All Items list and select it.
* Click OK.
* Click Check In.
* If you have a merge conflict, just keep local.

## 7. Examine Story for ChangeSet

* Refresh the Story by closing and reopening from the asset tray.
* Find a new item under Changesets.

## 8. Examine Story for Build

* Find a new item under Affected Build Runs.
