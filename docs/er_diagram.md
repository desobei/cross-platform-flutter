# CarStore Chen ER Diagram

Paste only the code inside the Mermaid block into Mermaid Live.

```mermaid
flowchart LR
    CUSTOMER[Customer]
    SHOWROOM[Showroom]
    CAR[Car]
    CATEGORY[Category]
    PURCHASE_ORDER[Purchase Order]
    RESERVATION[Reservation]
    SEARCH[Search]

    PLACES{places}
    PERFORMS{performs}
    SAVES{saves}
    PREFERS{prefers}
    OFFERS{offers}
    BELONGS_TO{belongs to}
    RESERVED_FOR{is reserved for}
    CONTAINS{contains}

    CUSTOMER ---|"1"| PLACES
    PLACES ---|"0..*"| PURCHASE_ORDER

    CUSTOMER ---|"1"| PERFORMS
    PERFORMS ---|"0..*"| SEARCH

    CUSTOMER ---|"0..*"| SAVES
    SAVES ---|"0..*"| CAR

    CUSTOMER ---|"0..1"| PREFERS
    PREFERS ---|"0..*"| SHOWROOM

    SHOWROOM ---|"1"| OFFERS
    OFFERS ---|"0..*"| CAR

    CAR ---|"0..*"| BELONGS_TO
    BELONGS_TO ---|"0..*"| CATEGORY

    CAR ---|"1"| RESERVED_FOR
    RESERVED_FOR ---|"0..*"| RESERVATION

    PURCHASE_ORDER ---|"1"| CONTAINS
    CONTAINS ---|"1..*"| RESERVATION

    CName([name])
    CEmail([email])
    CTheme([preferred theme])
    CUSTOMER --- CName
    CUSTOMER --- CEmail
    CUSTOMER --- CTheme

    SName([name])
    SCity([city])
    SSpecialty([specialty])
    SRating([rating])
    SHOWROOM --- SName
    SHOWROOM --- SCity
    SHOWROOM --- SSpecialty
    SHOWROOM --- SRating

    CarMake([make])
    CarModel([model])
    CarYear([year])
    CarPrice([price])
    CarTransmission([transmission])
    CarDrivetrain([drivetrain])
    CAR --- CarMake
    CAR --- CarModel
    CAR --- CarYear
    CAR --- CarPrice
    CAR --- CarTransmission
    CAR --- CarDrivetrain

    CatLabel([label])
    CATEGORY --- CatLabel

    OrderCustomer([customer name])
    OrderStatus([status])
    OrderCreated([created at])
    PURCHASE_ORDER --- OrderCustomer
    PURCHASE_ORDER --- OrderStatus
    PURCHASE_ORDER --- OrderCreated

    ResPackage([package name])
    ResMode([reservation mode])
    ResPickup([pickup date])
    ResStatus([status])
    RESERVATION --- ResPackage
    RESERVATION --- ResMode
    RESERVATION --- ResPickup
    RESERVATION --- ResStatus

    SearchQuery([query])
    SearchDate([searched at])
    SEARCH --- SearchQuery
    SEARCH --- SearchDate
```

## Chen Notation Guide

- Rectangles represent entities, such as `Customer`, `Car`, and `Showroom`.
- Diamonds represent relationships, such as `saves`, `places`, and `offers`.
- Ovals represent attributes, such as `name`, `price`, and `status`.
- Cardinalities are written on the relationship lines:
  - `1` means exactly one.
  - `0..1` means optional one.
  - `0..*` means zero or many.
  - `1..*` means one or many.
