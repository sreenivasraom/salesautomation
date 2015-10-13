trigger testTrigger on Account (before insert) {
Integer i =10;
List<Account> accList = new List<Account>();
for(Account acc: trigger.new)
{
i =1;
acc.name = 'Tooling API TEst '+i;
accList.add(acc);
}
i++;



}