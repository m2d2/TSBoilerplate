A project to be used as the starting point for a new iOS project

First steps after clone (and cd to TSBoilerplate)


    git submodule init
    git submodule upate
    sudo cp TSBoilerplate/TSBoilerplate/Model/CoreDataModel/MogenTemplate/mogenerator /usr/bin

Includes 
* MKNetworkKit    
* Mogenerator (Arc and NSCoding support for model files)
* Thanks to [Tyrone](https://github.com/tyrone-sudeium) for his guidance on Commands

## Data persistance:
Define your model using core data UI - add entities and properties. (Any properties that you want to persist must have a data type that supports NSCoding).
Inverse relationships are not supported at this stage.
The objects are generated as .h and .m files when you run the Generate Data Model target. 
You will have to drag newly generated class files into your project from finder. Model files are placed in ./Model/ModelObjects in Human and Machine folders. 
You are supposed to modify the human files only! This is for adding custom methods to your model objects should you desire them.
An example might be adding an accessor method to your model object that returns and ordered array for that model object's NSSet property. You would add this to the Human/ClassName.h and .m files. your patterns are your own, so this is not necessary. Do what you want!

## Networking: 
To use the networking subsystem - [Mugunth Kumar](https://github.com/MugunthKumar/MKNetworkKit) is the man! 

## Commands:
The commands subsystem is broken up into synchronous and asynchronous command which are exected by TSCommandRunner.
Commands are the method of having your controllers tell "the system" to do something and don't get bogged down with the business logic. As a general rule, anything can READ from the Model. As a general rule, only COMMANDS can change the model. 
Your view controller will get the user's data, for example a name, and set that on a command. It will then run a command to update a model object with that data. This allows decoupling of view controllers to model objects.

Example usage for Synchronous

    GroupCommand *groupCommand = [GroupCommand new];
    groupCommand.groupName = kGroupName;
    groupCommand.saveModel = YES; // at the end of the execute method, save the model.
    [[TSCommandRunner sharedCommandRunner] executeSynchronousCommand:groupCommand];

or Asynchronous

    MemberDisplayCommand *memberDisplayCommand = [MemberDisplayCommand new];
    memberDisplayCommand.group = [Model sharedModel].group;
    memberDisplayCommand.commandCompletionBlock = ^ (NSError *error) {
        DLog(@"Your first completion block!");
        DLog(@"Erorr says: %@", [error localizedDescription]);
    };
    [[TSCommandRunner sharedCommandRunner] executeAsynchronousCommand:memberDisplayCommand];

an Asynchronous Webservice command

    TwitterCommand *twitterCommand = [TwitterCommand new];
    twitterCommand.screenName = kTwitterScreenName;
    twitterCommand.includeRetweets = YES;
    twitterCommand.includeEntities = NO;
    twitterCommand.tweetCount = kTweetCount;
    twitterCommand.twitterCommandCompletionBlock = ^ (NSError *error) {
        if (error != nil) {
            DLog(@":( Erorr says: %@", [error localizedDescription]);
        } else {
            /* we don't know what's happened, but we trust that the model is updated. 
            The programmer doesn't need to handle the tweet results, the command has already done that.
            you would usually call something like [self.tableView reloadData] here */
            for (Tweet *tweet in [Model sharedModel].tweets) {
                DLog(@"%@ - %@", tweet.user.name, tweet.text);
            }
        }
    };
    [[TSCommandRunner sharedCommandRunner] executeAsynchronousCommand:twitterCommand];

## License
MIT License as per the LICENSE file and http://www.opensource.org/licenses/MIT