#[macro_use] extern crate rocket;
use rocket::tokio::time::{sleep, Duration};
use ledger::rocket_builder;

#[get("/<id>")]
async fn get_ledger(id: u8) -> String{
    sleep(Duration::from_secs(1)).await;
    format!("Ledger account {}", id)    
}

#[rocket::main]
async fn main() {
    if let Err(e) = rocket_builder().launch().await{
        println!("Error");
        drop(e);
    };
    // rocket::build().mount("/ledger", routes![get_ledger])
}

// can also use the following 
// useful when needed to inspect launch
// #[rocket::main]
// async fn main(){
//      rocket::build()
//            .mount("/", routes![index])
//            .launch()
//            .await;
// }