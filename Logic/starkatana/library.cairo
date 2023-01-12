%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256, uint256_add, assert_uint256_le
from starkware.cairo.common.math import assert_in_range, assert_le_felt
from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.token.erc721.enumerable.library import ERC721Enumerable
from openzeppelin.access.ownable.library import Ownable


//
// Storage
//

@storage_var
func Starkatana_max_supply() -> (max_supply: felt) {
}

@storage_var
func Starkatana_max_per_address() -> (max_per_address: felt) {
}

@storage_var
func Starkatana_minted_count_per_address(address: felt) -> (minted_count: felt) {
}

namespace Starkatana {
    //
    // Initializer
    //

    func initializer{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
        max_supply: felt
    ) {
        Starkatana_max_supply.write(max_supply);
        Starkatana_max_per_address.write(16);
        return ();
    }

    //
    // Getters
    //

    func max_supply{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
        max_supply: felt
    ) {
        return Starkatana_max_supply.read();
    }


    func minted_count{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        address: felt
    ) -> (minted_count: felt) {
        return Starkatana_minted_count_per_address.read(address);
    }

    func max_per_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
        max_per_address: felt
    ) {
        return Starkatana_max_per_address.read();
    }

    //
    // Private modifiers
    //


    func set_max_per_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        max_per_address: felt
    ) -> () {
        Ownable.assert_only_owner();
        Starkatana_max_per_address.write(max_per_address);
        return ();
    }

    func mint_count{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
        to: felt, count: felt
    ) {
        Ownable.assert_only_owner();
        _mint_count(to, count);
        return ();
    }

    //
    // Public modifiers
    //

    func mint_public{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() {
        alloc_locals;
        let (caller_address) = get_caller_address();
        _mint(caller_address);
        return ();
    }

    //
    // Unprotected
    //

    func _mint{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(to: felt) {
        alloc_locals;
        let (total_supply) = ERC721Enumerable.total_supply();
        let (max_supply_) = Starkatana.max_supply();
        let (new_token_id, _) = uint256_add(total_supply, Uint256(1, 0));
        with_attr error_message("Mint: cannot be more than 401 Starkatanas") {
            assert_uint256_le(new_token_id, Uint256(max_supply_, 0));
        }
        let (minted_count_) = minted_count(to);
        let (max_per_address_) = max_per_address();
        let new_minted_count = minted_count_ + 1;
        with_attr error_message("Mint: cannot mint more than 16 Starkatanas") {
            assert_le_felt(new_minted_count, max_per_address_);
        }
        ERC721Enumerable._mint(to, new_token_id);
        Starkatana_minted_count_per_address.write(to, new_minted_count);
        return ();
    }

    func _mint_count{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
        to: felt, count: felt
    ) {
        if (count == 0) {
            return ();
        }
        _mint(to);
        _mint_count(to, count - 1);
        return ();
    }
}
