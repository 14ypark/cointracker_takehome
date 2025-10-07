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
```git clone git@github.com:14ypark/cointracker_takehome.git```
```cd coin_tracker_takehome```
```bundle install```
```rails db:create```
```rails db:migrate```
```rails server```

API will be available at http://localhost:3000

# API ENDPOINT

POST   /api/addresses/:id/sync          -> sync addresses<br>
GET    /api/addresses/:id/transactions  -> view transactions <br>
GET    /api/addresses                   -> index (list all)<br>
POST   /api/addresses                   -> create (new address)<br>
GET    /api/addresses/:id               -> show (one address)<br>
DELETE /api/addresses/:id               -> destroy (delete)<br>


# Run tests

rspec 



