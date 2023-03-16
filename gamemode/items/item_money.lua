local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_money"
ITEM.WeaponClass = false

ITEM.Name = "Money"
ITEM.Desc = "DO NOT BUY!"
ITEM.Model = "models/food/hotdog.mdl"

ITEM.Price = 1200
ITEM.Max = 1

ITEM.Category = "Admin"   --SET CATAGORY TO ADMIN FOR ANY ITEM AND IT WONT BE ADDED TO THE MERCHANT STORE.

ITEM.Loot = false
ITEM.LootChance = 0.2

ITEM.Restrictions = false



--moneyvalue = math.random(250,1500)
money = {
	100,200,300,400,500,600,700,800,900,1000,
	150,250,350,450,550,650,750,850,950,1050,
}

function ITEM:OnUsed( ply, slot )
	local ranmon = table.Random(money)
	--print(moneyvalue)
	ply:AddMoney(ranmon)
	ply:ChatPrint("You found $"..ranmon)
	return true
end

function ITEM:OnDropped( ply )

end

ITEM.CustomOptions = {

}

item.Register( ITEM )
