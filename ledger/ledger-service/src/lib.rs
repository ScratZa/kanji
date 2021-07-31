#![feature(proc_macro_hygiene, decl_macro)]
#![allow(unused_attributes)]

#[macro_use] extern crate rocket;
use rocket::{Rocket, Build};
use rocket::shield::Shield;
mod routes;


pub fn rocket_builder() -> Rocket<Build>  {
    rocket::build()
            .attach(Shield::new())
            .mount("/ledger",routes![routes::ledger_routes::get_ledger, routes::ledger_routes::get_ledgers])
            .register("/ledger", catchers![routes::ledger_routes::ledger_not_found])
}