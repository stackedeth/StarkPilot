use starknet::{ContractAddress, ContractAddressIntoFelt252};
use array::{ArrayTrait, SpanTrait};
use traits::{Into};
use hash::{LegacyHash};
use starknet::{SyscallResult, syscalls::call_contract_syscall};
use result::{ResultTrait};

#[derive(Drop, Serde)]
struct Call {
    from: ContractAddress,
    to: ContractAddress,
    selector: felt252,
    amount: u256,
    calldata: Array<felt252>
}

#[generate_trait]
impl CallTraitImpl of CallTrait {
    fn hash(self: @Call) -> felt252 {
        let mut data_hash = 0;
        let mut data_span = self.calldata.span();
        loop {
            match data_span.pop_front() {
                Option::Some(word) => {
                    data_hash = pedersen(data_hash, *word);
                },
                Option::None(_) => {
                    break;
                }
            };
        };

        pedersen(pedersen((*self.from).into(), *self.selector), data_hash)
    }
}


