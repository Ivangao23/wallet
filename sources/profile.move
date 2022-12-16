module wallet::profile {
    use sui::object::{Self,UID};
    use sui::tx_context::{Self,TxContext};
    use sui::transfer;
    use std::string::{Self,String};
    use std::vector;
    use sui::url::{Self, Url};

    struct Profile has key,store {
        id : UID,
        name : String,
        description : String,
        picture : Url,
    }

    public entry fun create(name : vector<u8>, ctx : &mut TxContext) {
        let profile = Profile {
            id : object::new(ctx),
            name : string::utf8(name),
            description : string::utf8(b""),
            picture: url::new_unsafe_from_bytes(b""),
        };
        transfer::transfer(profile, tx_context::sender(ctx));
    }

    public entry fun setName(profile : &mut Profile, name: vector<u8>) {
        profile.name = string::utf8(name);
    }

    public entry fun setDescription(profile : &mut Profile, description: vector<u8>) {
        profile.description = string::utf8(description);
    }

    public entry fun setPicture(profile : &mut Profile, picture: vector<u8>) {
        profile.picture = url::new_unsafe_from_bytes(picture);
    }

}