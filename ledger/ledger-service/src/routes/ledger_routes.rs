#![allow(dead_code)]

use rocket::*;
use rocket::tokio::time::{sleep, Duration};
use rocket::response::{content};

#[get("/")]
pub async fn get_ledgers() -> String {
    sleep(Duration::from_secs(1)).await;
    format!("Ledgers") 
}

#[get("/<id>")]
pub async fn get_ledger(id: u8) -> String{
    sleep(Duration::from_secs(1)).await;
    format!("Ledger account {}", id)    
}

#[catch(404)]
pub fn ledger_not_found(req: &Request<'_>) -> content::Html<String> {
    content::Html(format!("\
        <p>Sorry, but '{}' is not a valid path!</p>\
        <p>Try visiting /ledger/&lt;id&gt; instead.</p>",
        req.uri()))
}