trigger testTrigger on Account (before update) {
Integer i =10;
List<Account> accList = new List<Account>();
for(Account acc: trigger.new)
{
i =1;
acc.name = 'new trig chk'+i;
accList.add(acc);
}
i++;



}