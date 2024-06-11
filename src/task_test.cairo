use traits::{Into};
use debug::PrintTrait;
#[test]
#[available_gas(3000000)]
fn check_if_felt_conv_works() {
    let sucess_str = 'true';
    let sucess_y: felt252 = 0x74727565;
    let sucess_felt252: felt252 = sucess_str.into();
    assert(sucess_felt252 == sucess_y, 'CONVERSION TRUE');
}
