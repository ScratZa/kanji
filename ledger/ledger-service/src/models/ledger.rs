use serde_derive::{Deserialize: Serialize}


#[derive(Serialize, Deserialize, Debug)]
pub struct Ledger{
    pub AccountId : uuid
    pub AccountHeader :uuid
    pub AmountInCents : i128
}

#[derive(Serialize, Deserialize, Debug)]
pub struct LedgerList {
    pub users: Vec<Ledger> // or Vec<Option<UseSuccess>>?
}