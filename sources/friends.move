module wallet::friends {
    use sui::object::{Self,UID};
    use sui::tx_context::{Self,TxContext};
    use sui::transfer;
    use std::vector;

    struct Friends has key, store {
        id : UID,
        list : vector<address>,
    }

    public entry fun create(ctx : &mut TxContext) {
        let friends = Friends {
            id : object::new(ctx),
            list : vector::empty<address>(),
        };

        transfer::transfer(friends, tx_context::sender(ctx));
    }

    public entry fun addFriend(friends: &mut Friends, addr: address) {
        vector::push_back<address>(&mut friends.list, addr);
    }

    public entry fun deleteFriend(friends: &mut Friends, addr: address) {
        let (_,no) = vector::index_of<address>(&friends.list, &addr);
        vector::remove<address>(&mut friends.list, no);
    }



}
