# README

# CoinTracker Takehome Assessment

A Rails backend for tracking Bitcoin transactions, addresses

# Core Features

Adding, removing addresses as well as synchronizing bitcoin wallet transactions. 
functioning API design
Error handling and validations
DB schema 

A very scalable backend with little room for unexpected error. 

# Stack used

Ruby<br>
Rails<br>
PostgreSQL<br>
RSpec<br>
HTTParty<br>
BlockChair API<br>

## Setup instructions

# Prerequisites
ruby 3.2.2<br>
PostgreSQL 14<br>
Bundler<br>

# Installation
```git clone git@github.com:14ypark/cointracker_takehome.git```<br>
```cd coin_tracker_takehome```<br>
```bundle install```<br>
```rails db:create```<br>
```rails db:migrate```<br>
```rails server```<br>

API will be available at http://localhost:3000

## API Endpoints

| METHOD | ENDPOINT | DESCRIPTION |
|--------|-------------------------------|-------------------------|
| POST   | /api/addresses/:id/sync       | Sync address            |
| GET    | /api/addresses/:id/transactions | View transactions      |
| GET    | /api/addresses                | List all addresses      |
| POST   | /api/addresses                | Create new address      |
| GET    | /api/addresses/:id            | Show one address        |
| DELETE | /api/addresses/:id            | Delete address          |


# Run tests

rspec 

# Manual testing 

1. postman can be used to test the application manually.<br>
2. Endpoints can be easily tested by doing the following.<br>
3. GET<br>
   <img width="838" height="641" alt="Screenshot 2025-10-07 at 3 09 31 PM" src="https://github.com/user-attachments/assets/efdaf2c7-15f8-4c99-82a3-c7e4cfb7cd26" /><br>
4. POST<br>
   <img width="816" height="628" alt="Screenshot 2025-10-07 at 3 10 49 PM" src="https://github.com/user-attachments/assets/ffe799fa-e661-4bca-b470-a7794a46e610" /><br>
5. sync<br>
   <img width="829" height="652" alt="Screenshot 2025-10-07 at 3 11 32 PM" src="https://github.com/user-attachments/assets/a2fc336c-f505-4b2b-90d1-49f3d6ec256a" /><br>

# Future enhancements

# version 1.0<br>
1. background job to sync the addresses<br>
2. address format validation with regex<br>
3. pagination improvement
4. Service tests

# version 2.0 <br>
1. Authentication/security enhancements
2. Rate limiters
3. Caching
4. Logging (cloudwatch)
5. Tax calculation/reporting


Ran into rate limit issues with blockchair so had to switch to blockchain.com. 

