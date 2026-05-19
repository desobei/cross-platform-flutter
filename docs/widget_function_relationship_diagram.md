# CarStore Complete Chen ER Diagram

## Bug Fix

The parse error came from mixing Markdown headers with Mermaid parsing after a
diagram fence boundary. This file now keeps Markdown text outside Mermaid blocks
and contains one complete Mermaid block. Inside the block, Chen notation is used:
entities are `[]`, relationships are `{}`, and attributes/functions are `()`.

## Complete Mermaid Chen ER Diagram

```mermaid
flowchart LR
    Customer["Customer"]
    Showroom["Showroom"]
    Car["Car"]
    Category["Category"]
    Reservation["Reservation"]
    PurchaseOrder["Purchase Order"]
    Search["Search"]
    AdvisorMessage["Advisor Message"]
    AuthSession["Authentication Session"]
    ThemePreference["Theme Preference"]
    ColorPreference["Color Preference"]

    ShowroomModel["Showroom model"]
    CarCategoryModel["CarCategory model"]
    CuratorPostModel["CuratorPost model"]
    DriverActivityModel["DriverActivity model"]
    CarListingModel["CarListing model"]
    ReservationItemModel["ReservationItem model"]
    PurchaseOrderModel["PurchaseOrder model"]
    DealerMessageModel["DealerMessage model"]
    CarSearchResultsModel["CarSearchResults model"]
    CarSearchResultModel["CarSearchResult model"]
    CarStoreTabEnum["CarStoreTab enum"]
    ReservationModeEnum["ReservationMode enum"]

    MainFunction["main"]
    FirebaseOptionsModel["DefaultFirebaseOptions"]
    CarStoreAppWidget["CarStoreApp widget"]
    CarStoreAppStateWidget["_CarStoreAppState widget"]
    CarStoreShellWidget["CarStoreShell widget"]
    CarStoreStateEntity["CarStoreState"]
    CarStoreScopeWidget["CarStoreScope widget"]
    CarStoreBackdropWidget["CarStoreBackdrop widget"]
    GlowBlobWidget["_GlowBlob widget"]

    LoginPageWidget["LoginPage widget"]
    LoginPageStateWidget["_LoginPageState widget"]
    BrandPaneWidget["_BrandPane widget"]
    LoginFormPaneWidget["_LoginFormPane widget"]
    FeatureLineWidget["_FeatureLine widget"]

    DiscoverPageWidget["DiscoverPage widget"]
    DiscoverPageStateWidget["_DiscoverPageState widget"]
    SearchCardWidget["_SearchCard widget"]
    SearchResultCardWidget["_SearchResultCard widget"]
    SectionHeaderWidget["_SectionHeader widget"]
    ShowroomRailCardWidget["_ShowroomRailCard widget"]
    ActivityCardWidget["_ActivityCard widget"]
    CategoryCardWidget["_CategoryCard widget"]
    SavedCarCardWidget["_SavedCarCard widget"]
    DiscoverImageWidget["_ImageWithFallback discover widget"]
    CategorySheetFunction["_openCategorySheet function"]

    ShowroomPageWidget["ShowroomPage widget"]
    InventoryRowWidget["_InventoryRow widget"]
    CarSheetFunction["_openCarSheet function"]
    CounterButtonWidget["_CounterButton widget"]
    ShowroomImageWidget["_ImageWithFallback showroom widget"]
    FallbackArtWidget["_FallbackArt widget"]

    CheckoutPageWidget["CheckoutPage widget"]
    CheckoutPageStateWidget["_CheckoutPageState widget"]
    GroupedReservationModel["_GroupedReservation model"]

    OrdersPageWidget["OrdersPage widget"]
    SummaryDotWidget["_SummaryDot widget"]

    AdvisorChatPageWidget["AdvisorChatPage widget"]
    AdvisorChatPageStateWidget["_AdvisorChatPageState widget"]
    MessageBubbleWidget["_MessageBubble widget"]

    AccountPageWidget["AccountPage widget"]
    ColorChoiceWidget["_ColorChoice widget"]

    CarStoreRepositoryEntity["CarStoreRepository"]
    CarStoreLocalRepositoryEntity["CarStoreLocalRepository"]
    CarApiServiceEntity["CarApiCarSearchService"]
    DealerChatServiceEntity["DealerChatService"]
    LocalDealerChatServiceEntity["LocalDealerChatService"]
    FirebaseDealerChatServiceEntity["FirebaseDealerChatService"]
    FirebaseAuthEntity["Firebase Auth"]
    FirestoreEntity["Cloud Firestore"]
    CarApiEntity["CarAPI VIN endpoint"]
    SharedPreferencesEntity["SharedPreferences"]

    CarStoreDatabaseEntity["CarStoreDatabase"]
    FavoriteCarsTable["FavoriteCars table"]
    DbReservationItemsTable["DbReservationItems table"]
    DbPurchaseOrdersTable["DbPurchaseOrders table"]
    DbPurchaseOrderItemsTable["DbPurchaseOrderItems table"]
    FavoriteCarDaoEntity["FavoriteCarDao"]
    ReservationDaoEntity["ReservationDao"]
    PurchaseOrderDaoEntity["PurchaseOrderDao"]
    DriftConnectionEntity["Drift connection"]

    RPlaces{"places"}
    RPerforms{"performs"}
    RSaves{"saves"}
    RPrefersTheme{"prefers theme"}
    RPrefersColor{"prefers color"}
    RUsesAuth{"uses auth"}
    RMessages{"sends and reads"}
    ROffers{"offers"}
    RBelongsTo{"belongs to"}
    RReservedFor{"is reserved for"}
    RContains{"contains"}
    RSearchReturns{"returns"}
    RBackedByModel{"backed by model"}
    RBuilds{"builds"}
    RRoutesTo{"routes to"}
    RCallsState{"calls state"}
    RReadsStaticData{"reads static data"}
    RPersistsPrefs{"persists preferences"}
    RPersistsDb{"persists local data"}
    RQueriesApi{"queries api"}
    RImplementsChat{"implements chat contract"}
    RAuthenticates{"authenticates"}
    RStoresMessages{"stores messages"}
    RUsesDao{"uses dao"}
    RUsesTable{"uses table"}
    ROpensDatabase{"opens database"}
    RHydrates{"hydrates"}
    RWrites{"writes"}
    RDisplays{"displays"}

    Customer --- RPlaces --- PurchaseOrder
    Customer --- RPerforms --- Search
    Customer --- RSaves --- Car
    Customer --- RPrefersTheme --- ThemePreference
    Customer --- RPrefersColor --- ColorPreference
    Customer --- RUsesAuth --- AuthSession
    Customer --- RMessages --- AdvisorMessage
    Showroom --- ROffers --- Car
    Car --- RBelongsTo --- Category
    Car --- RReservedFor --- Reservation
    PurchaseOrder --- RContains --- Reservation
    Search --- RSearchReturns --- CarSearchResultsModel
    CarSearchResultsModel --- RContains --- CarSearchResultModel

    Showroom --- RBackedByModel --- ShowroomModel
    Category --- RBackedByModel --- CarCategoryModel
    Car --- RBackedByModel --- CarListingModel
    Reservation --- RBackedByModel --- ReservationItemModel
    PurchaseOrder --- RBackedByModel --- PurchaseOrderModel
    AdvisorMessage --- RBackedByModel --- DealerMessageModel

    CarStoreAppWidget --- RBuilds --- CarStoreShellWidget
    CarStoreAppWidget --- RBuilds --- CarStoreScopeWidget
    CarStoreAppWidget --- RBuilds --- CarStoreBackdropWidget
    CarStoreBackdropWidget --- RBuilds --- GlowBlobWidget
    CarStoreAppWidget --- RRoutesTo --- LoginPageWidget
    CarStoreAppWidget --- RRoutesTo --- DiscoverPageWidget
    CarStoreAppWidget --- RRoutesTo --- OrdersPageWidget
    CarStoreAppWidget --- RRoutesTo --- AdvisorChatPageWidget
    CarStoreAppWidget --- RRoutesTo --- AccountPageWidget
    CarStoreAppWidget --- RRoutesTo --- ShowroomPageWidget
    CarStoreAppWidget --- RRoutesTo --- CheckoutPageWidget

    LoginPageWidget --- RBuilds --- LoginPageStateWidget
    LoginPageWidget --- RBuilds --- BrandPaneWidget
    LoginPageWidget --- RBuilds --- LoginFormPaneWidget
    BrandPaneWidget --- RBuilds --- FeatureLineWidget

    DiscoverPageWidget --- RBuilds --- DiscoverPageStateWidget
    DiscoverPageWidget --- RBuilds --- SearchCardWidget
    DiscoverPageWidget --- RBuilds --- SearchResultCardWidget
    DiscoverPageWidget --- RBuilds --- SectionHeaderWidget
    DiscoverPageWidget --- RBuilds --- ShowroomRailCardWidget
    DiscoverPageWidget --- RBuilds --- ActivityCardWidget
    DiscoverPageWidget --- RBuilds --- CategoryCardWidget
    DiscoverPageWidget --- RBuilds --- SavedCarCardWidget
    DiscoverPageWidget --- RBuilds --- DiscoverImageWidget
    CategoryCardWidget --- RBuilds --- CategorySheetFunction

    ShowroomPageWidget --- RBuilds --- InventoryRowWidget
    ShowroomPageWidget --- RBuilds --- CarSheetFunction
    CarSheetFunction --- RBuilds --- CounterButtonWidget
    ShowroomPageWidget --- RBuilds --- ShowroomImageWidget
    ShowroomImageWidget --- RBuilds --- FallbackArtWidget

    CheckoutPageWidget --- RBuilds --- CheckoutPageStateWidget
    CheckoutPageWidget --- RBuilds --- GroupedReservationModel
    OrdersPageWidget --- RBuilds --- SummaryDotWidget
    AdvisorChatPageWidget --- RBuilds --- AdvisorChatPageStateWidget
    AdvisorChatPageWidget --- RBuilds --- MessageBubbleWidget
    AccountPageWidget --- RBuilds --- ColorChoiceWidget

    LoginPageWidget --- RCallsState --- CarStoreStateEntity
    DiscoverPageWidget --- RCallsState --- CarStoreStateEntity
    ShowroomPageWidget --- RCallsState --- CarStoreStateEntity
    CheckoutPageWidget --- RCallsState --- CarStoreStateEntity
    OrdersPageWidget --- RCallsState --- CarStoreStateEntity
    AdvisorChatPageWidget --- RCallsState --- CarStoreStateEntity
    AccountPageWidget --- RCallsState --- CarStoreStateEntity

    DiscoverPageWidget --- RReadsStaticData --- CarStoreRepositoryEntity
    ShowroomPageWidget --- RReadsStaticData --- CarStoreRepositoryEntity
    CarApiServiceEntity --- RReadsStaticData --- CarStoreRepositoryEntity

    CarStoreStateEntity --- RPersistsPrefs --- SharedPreferencesEntity
    CarStoreStateEntity --- RPersistsDb --- CarStoreLocalRepositoryEntity
    CarStoreStateEntity --- RQueriesApi --- CarApiServiceEntity
    CarStoreStateEntity --- RImplementsChat --- DealerChatServiceEntity

    DealerChatServiceEntity --- RImplementsChat --- LocalDealerChatServiceEntity
    DealerChatServiceEntity --- RImplementsChat --- FirebaseDealerChatServiceEntity
    FirebaseDealerChatServiceEntity --- RAuthenticates --- FirebaseAuthEntity
    FirebaseDealerChatServiceEntity --- RStoresMessages --- FirestoreEntity
    CarApiServiceEntity --- RQueriesApi --- CarApiEntity

    CarStoreLocalRepositoryEntity --- RUsesDao --- FavoriteCarDaoEntity
    CarStoreLocalRepositoryEntity --- RUsesDao --- ReservationDaoEntity
    CarStoreLocalRepositoryEntity --- RUsesDao --- PurchaseOrderDaoEntity
    FavoriteCarDaoEntity --- RUsesTable --- FavoriteCarsTable
    ReservationDaoEntity --- RUsesTable --- DbReservationItemsTable
    PurchaseOrderDaoEntity --- RUsesTable --- DbPurchaseOrdersTable
    PurchaseOrderDaoEntity --- RUsesTable --- DbPurchaseOrderItemsTable
    FavoriteCarsTable --- RBackedByModel --- Car
    DbReservationItemsTable --- RBackedByModel --- Reservation
    DbPurchaseOrdersTable --- RBackedByModel --- PurchaseOrder
    DbPurchaseOrderItemsTable --- RBackedByModel --- Reservation
    CarStoreDatabaseEntity --- RUsesTable --- FavoriteCarsTable
    CarStoreDatabaseEntity --- RUsesTable --- DbReservationItemsTable
    CarStoreDatabaseEntity --- RUsesTable --- DbPurchaseOrdersTable
    CarStoreDatabaseEntity --- RUsesTable --- DbPurchaseOrderItemsTable
    CarStoreDatabaseEntity --- ROpensDatabase --- DriftConnectionEntity

    ACustomerName("name")
    ACustomerEmail("email")
    ACustomerPassword("password")
    ACustomerLoggedIn("loggedIn")
    ACustomerThemeMode("themeMode")
    ACustomerSeedColor("seedColor")
    ACustomerSelectedTab("selectedTab")
    Customer --- ACustomerName
    Customer --- ACustomerEmail
    Customer --- ACustomerPassword
    Customer --- ACustomerLoggedIn
    Customer --- ACustomerThemeMode
    Customer --- ACustomerSeedColor
    Customer --- ACustomerSelectedTab

    AShowroomId("id")
    AShowroomName("name")
    AShowroomCity("city")
    AShowroomSpecialty("specialty")
    AShowroomRating("rating")
    AShowroomAccentColor("accentColor")
    AShowroomDescription("description")
    Showroom --- AShowroomId
    Showroom --- AShowroomName
    Showroom --- AShowroomCity
    Showroom --- AShowroomSpecialty
    Showroom --- AShowroomRating
    Showroom --- AShowroomAccentColor
    Showroom --- AShowroomDescription

    ACarId("id")
    ACarShowroomId("showroomId")
    ACarMake("make")
    ACarModel("model")
    ACarYear("year")
    ACarPrice("price")
    ACarRangeMileage("rangeOrMileage")
    ACarHighlight("highlight")
    ACarDescription("description")
    ACarColors("colors")
    ACarTransmission("transmission")
    ACarDrivetrain("drivetrain")
    ACarAccentColor("accentColor")
    Car --- ACarId
    Car --- ACarShowroomId
    Car --- ACarMake
    Car --- ACarModel
    Car --- ACarYear
    Car --- ACarPrice
    Car --- ACarRangeMileage
    Car --- ACarHighlight
    Car --- ACarDescription
    Car --- ACarColors
    Car --- ACarTransmission
    Car --- ACarDrivetrain
    Car --- ACarAccentColor

    ACategoryLabel("label")
    ACategoryIcon("icon")
    ACategoryImage("imageAssetPath")
    Category --- ACategoryLabel
    Category --- ACategoryIcon
    Category --- ACategoryImage

    AReservationCar("car")
    AReservationPackage("packageName")
    AReservationMode("mode")
    AReservationPickupDate("pickupDateLabel")
    Reservation --- AReservationCar
    Reservation --- AReservationPackage
    Reservation --- AReservationMode
    Reservation --- AReservationPickupDate

    AOrderId("id")
    AOrderCustomerName("customerName")
    AOrderMode("mode")
    AOrderPickupDate("pickupDateLabel")
    AOrderItems("items")
    AOrderStatus("status")
    PurchaseOrder --- AOrderId
    PurchaseOrder --- AOrderCustomerName
    PurchaseOrder --- AOrderMode
    PurchaseOrder --- AOrderPickupDate
    PurchaseOrder --- AOrderItems
    PurchaseOrder --- AOrderStatus

    ASearchQuery("query")
    ASearchRecent("recentSearches")
    ASearchResultCount("resultCount")
    Search --- ASearchQuery
    Search --- ASearchRecent
    Search --- ASearchResultCount

    AMessageDate("date")
    AMessageSenderId("senderId")
    AMessageSenderName("senderName")
    AMessageText("text")
    AMessageReference("reference")
    AdvisorMessage --- AMessageDate
    AdvisorMessage --- AMessageSenderId
    AdvisorMessage --- AMessageSenderName
    AdvisorMessage --- AMessageText
    AdvisorMessage --- AMessageReference

    ACuratorPostTitle("title")
    ACuratorPostAuthor("author")
    ACuratorPostSummary("summary")
    ACuratorPostReadTime("readTime")
    CuratorPostModel --- ACuratorPostTitle
    CuratorPostModel --- ACuratorPostAuthor
    CuratorPostModel --- ACuratorPostSummary
    CuratorPostModel --- ACuratorPostReadTime

    ADriverActivityName("name")
    ADriverActivityNote("note")
    ADriverActivityTimeAgo("timeAgo")
    DriverActivityModel --- ADriverActivityName
    DriverActivityModel --- ADriverActivityNote
    DriverActivityModel --- ADriverActivityTimeAgo

    ASearchResultsData("data")
    ASearchResultYear("year")
    ASearchResultMake("make")
    ASearchResultModel("model")
    ASearchResultTrim("trim")
    ASearchResultVin("vin")
    CarSearchResultsModel --- ASearchResultsData
    CarSearchResultModel --- ASearchResultYear
    CarSearchResultModel --- ASearchResultMake
    CarSearchResultModel --- ASearchResultModel
    CarSearchResultModel --- ASearchResultTrim
    CarSearchResultModel --- ASearchResultVin

    ADbFavoriteCarId("carId primary key")
    ADbFavoriteSavedAt("savedAt")
    FavoriteCarsTable --- ADbFavoriteCarId
    FavoriteCarsTable --- ADbFavoriteSavedAt

    ADbReservationId("id primary key")
    ADbReservationCarId("carId")
    ADbReservationPackage("packageName")
    ADbReservationCreatedAt("createdAt")
    DbReservationItemsTable --- ADbReservationId
    DbReservationItemsTable --- ADbReservationCarId
    DbReservationItemsTable --- ADbReservationPackage
    DbReservationItemsTable --- ADbReservationCreatedAt

    ADbOrderId("id primary key")
    ADbOrderCustomerName("customerName")
    ADbOrderMode("mode")
    ADbOrderPickupDate("pickupDateLabel")
    ADbOrderStatus("status")
    ADbOrderCreatedAt("createdAt")
    DbPurchaseOrdersTable --- ADbOrderId
    DbPurchaseOrdersTable --- ADbOrderCustomerName
    DbPurchaseOrdersTable --- ADbOrderMode
    DbPurchaseOrdersTable --- ADbOrderPickupDate
    DbPurchaseOrdersTable --- ADbOrderStatus
    DbPurchaseOrdersTable --- ADbOrderCreatedAt

    ADbOrderItemId("id primary key")
    ADbOrderItemOrderId("orderId foreign key")
    ADbOrderItemCarId("carId")
    ADbOrderItemPackage("packageName")
    ADbOrderItemPosition("position")
    DbPurchaseOrderItemsTable --- ADbOrderItemId
    DbPurchaseOrderItemsTable --- ADbOrderItemOrderId
    DbPurchaseOrderItemsTable --- ADbOrderItemCarId
    DbPurchaseOrderItemsTable --- ADbOrderItemPackage
    DbPurchaseOrderItemsTable --- ADbOrderItemPosition

    FMain("main")
    FFirebaseCurrentPlatform("currentPlatform")
    FAppInitState("initState")
    FAppDispose("dispose")
    FAppBuild("build")
    FShellBuild("build")
    MainFunction --- FMain
    FirebaseOptionsModel --- FFirebaseCurrentPlatform
    CarStoreAppStateWidget --- FAppInitState
    CarStoreAppStateWidget --- FAppDispose
    CarStoreAppStateWidget --- FAppBuild
    CarStoreShellWidget --- FShellBuild

    FStateHydratePrefs("_hydrateFromPreferences")
    FStateHydrateDatabase("_hydrateFromDatabase")
    FStateSignIn("signIn")
    FStateSignUp("signUp")
    FStateSignOut("signOut")
    FStateSyncSelectedTab("syncSelectedTab")
    FStateSetSelectedTab("setSelectedTab")
    FStateChangeThemeMode("changeThemeMode")
    FStateChangeSeedColor("changeSeedColor")
    FStateAddReservation("addReservation")
    FStateRemoveReservationAt("removeReservationAt")
    FStateIsFavorite("isFavorite")
    FStateToggleFavorite("toggleFavorite")
    FStateSubmitOrder("submitOrder")
    FStateWatchAdvisorMessages("watchAdvisorMessages")
    FStateSendAdvisorMessage("sendAdvisorMessage")
    FStateSearchCars("searchCars")
    FStateRememberSearch("_rememberSearch")
    FStateQueueDatabaseWrite("_queueDatabaseWrite")
    FStateDispose("dispose")
    CarStoreStateEntity --- FStateHydratePrefs
    CarStoreStateEntity --- FStateHydrateDatabase
    CarStoreStateEntity --- FStateSignIn
    CarStoreStateEntity --- FStateSignUp
    CarStoreStateEntity --- FStateSignOut
    CarStoreStateEntity --- FStateSyncSelectedTab
    CarStoreStateEntity --- FStateSetSelectedTab
    CarStoreStateEntity --- FStateChangeThemeMode
    CarStoreStateEntity --- FStateChangeSeedColor
    CarStoreStateEntity --- FStateAddReservation
    CarStoreStateEntity --- FStateRemoveReservationAt
    CarStoreStateEntity --- FStateIsFavorite
    CarStoreStateEntity --- FStateToggleFavorite
    CarStoreStateEntity --- FStateSubmitOrder
    CarStoreStateEntity --- FStateWatchAdvisorMessages
    CarStoreStateEntity --- FStateSendAdvisorMessage
    CarStoreStateEntity --- FStateSearchCars
    CarStoreStateEntity --- FStateRememberSearch
    CarStoreStateEntity --- FStateQueueDatabaseWrite
    CarStoreStateEntity --- FStateDispose

    FRepoShowroomById("showroomById")
    FRepoShowroomHeroAsset("showroomHeroAsset")
    FRepoCarImageAsset("carImageAsset")
    FRepoListingsForCategory("listingsForCategory")
    FRepoListingsForShowroom("listingsForShowroom")
    FRepoCarById("carById")
    CarStoreRepositoryEntity --- FRepoShowroomById
    CarStoreRepositoryEntity --- FRepoShowroomHeroAsset
    CarStoreRepositoryEntity --- FRepoCarImageAsset
    CarStoreRepositoryEntity --- FRepoListingsForCategory
    CarStoreRepositoryEntity --- FRepoListingsForShowroom
    CarStoreRepositoryEntity --- FRepoCarById

    FLocalFindFavoriteCarIds("findFavoriteCarIds")
    FLocalFindReservationItems("findReservationItems")
    FLocalFindOrders("findOrders")
    FLocalSaveFavoriteCar("saveFavoriteCar")
    FLocalDeleteFavoriteCar("deleteFavoriteCar")
    FLocalClearFavoriteCars("clearFavoriteCars")
    FLocalSaveReservationItem("saveReservationItem")
    FLocalReplaceReservationItems("replaceReservationItems")
    FLocalClearReservationItems("clearReservationItems")
    FLocalSaveOrder("saveOrder")
    FLocalClose("close")
    FLocalCarByIdOrNull("_carByIdOrNull")
    CarStoreLocalRepositoryEntity --- FLocalFindFavoriteCarIds
    CarStoreLocalRepositoryEntity --- FLocalFindReservationItems
    CarStoreLocalRepositoryEntity --- FLocalFindOrders
    CarStoreLocalRepositoryEntity --- FLocalSaveFavoriteCar
    CarStoreLocalRepositoryEntity --- FLocalDeleteFavoriteCar
    CarStoreLocalRepositoryEntity --- FLocalClearFavoriteCars
    CarStoreLocalRepositoryEntity --- FLocalSaveReservationItem
    CarStoreLocalRepositoryEntity --- FLocalReplaceReservationItems
    CarStoreLocalRepositoryEntity --- FLocalClearReservationItems
    CarStoreLocalRepositoryEntity --- FLocalSaveOrder
    CarStoreLocalRepositoryEntity --- FLocalClose
    CarStoreLocalRepositoryEntity --- FLocalCarByIdOrNull

    FFavoriteFindAll("findAllFavoriteCars")
    FFavoriteInsert("insertFavoriteCar")
    FFavoriteDelete("deleteFavoriteCar")
    FFavoriteClear("clearFavoriteCars")
    FavoriteCarDaoEntity --- FFavoriteFindAll
    FavoriteCarDaoEntity --- FFavoriteInsert
    FavoriteCarDaoEntity --- FFavoriteDelete
    FavoriteCarDaoEntity --- FFavoriteClear

    FReservationFindAll("findAllReservationItems")
    FReservationInsert("insertReservationItem")
    FReservationDelete("deleteReservationItem")
    FReservationClear("clearReservationItems")
    ReservationDaoEntity --- FReservationFindAll
    ReservationDaoEntity --- FReservationInsert
    ReservationDaoEntity --- FReservationDelete
    ReservationDaoEntity --- FReservationClear

    FOrderFindAll("findAllOrders")
    FOrderFindItems("findOrderItems")
    FOrderInsertWithItems("insertOrderWithItems")
    FOrderClear("clearOrders")
    PurchaseOrderDaoEntity --- FOrderFindAll
    PurchaseOrderDaoEntity --- FOrderFindItems
    PurchaseOrderDaoEntity --- FOrderInsertWithItems
    PurchaseOrderDaoEntity --- FOrderClear

    FCarApiQueryCars("queryCars")
    FCarApiQueryVin("_queryVin")
    FCarApiListingsMatchingSpecs("_listingsMatchingApiSpecs")
    CarApiServiceEntity --- FCarApiQueryCars
    CarApiServiceEntity --- FCarApiQueryVin
    CarApiServiceEntity --- FCarApiListingsMatchingSpecs

    FChatSupportsEmail("supportsEmailPasswordAuth")
    FChatSignIn("signIn")
    FChatSignUp("signUp")
    FChatSignOut("signOut")
    FChatWatchMessages("watchMessages")
    FChatSendMessage("sendMessage")
    FChatDispose("dispose")
    DealerChatServiceEntity --- FChatSupportsEmail
    DealerChatServiceEntity --- FChatSignIn
    DealerChatServiceEntity --- FChatSignUp
    DealerChatServiceEntity --- FChatSignOut
    DealerChatServiceEntity --- FChatWatchMessages
    DealerChatServiceEntity --- FChatSendMessage
    DealerChatServiceEntity --- FChatDispose

    FLocalChatSignIn("signIn")
    FLocalChatSignUp("signUp")
    FLocalChatSignOut("signOut")
    FLocalChatWatchMessages("watchMessages")
    FLocalChatSendMessage("sendMessage")
    FLocalChatDispose("dispose")
    LocalDealerChatServiceEntity --- FLocalChatSignIn
    LocalDealerChatServiceEntity --- FLocalChatSignUp
    LocalDealerChatServiceEntity --- FLocalChatSignOut
    LocalDealerChatServiceEntity --- FLocalChatWatchMessages
    LocalDealerChatServiceEntity --- FLocalChatSendMessage
    LocalDealerChatServiceEntity --- FLocalChatDispose

    FFirebaseChatSignIn("signIn")
    FFirebaseChatSignUp("signUp")
    FFirebaseChatSignOut("signOut")
    FFirebaseChatWatchMessages("watchMessages")
    FFirebaseChatSendMessage("sendMessage")
    FFirebaseChatDisplayName("_displayNameFromEmail")
    FFirebaseChatErrorMessage("_messageForAuthError")
    FirebaseDealerChatServiceEntity --- FFirebaseChatSignIn
    FirebaseDealerChatServiceEntity --- FFirebaseChatSignUp
    FirebaseDealerChatServiceEntity --- FFirebaseChatSignOut
    FirebaseDealerChatServiceEntity --- FFirebaseChatWatchMessages
    FirebaseDealerChatServiceEntity --- FFirebaseChatSendMessage
    FirebaseDealerChatServiceEntity --- FFirebaseChatDisplayName
    FirebaseDealerChatServiceEntity --- FFirebaseChatErrorMessage

    FLoginInitState("initState")
    FLoginDispose("dispose")
    FLoginBuild("build")
    FLoginHandleAuth("_handleAuthAction")
    LoginPageStateWidget --- FLoginInitState
    LoginPageStateWidget --- FLoginDispose
    LoginPageStateWidget --- FLoginBuild
    LoginPageStateWidget --- FLoginHandleAuth

    FDiscoverInitState("initState")
    FDiscoverDispose("dispose")
    FDiscoverBuild("build")
    FDiscoverRunSearch("_runSearch")
    DiscoverPageStateWidget --- FDiscoverInitState
    DiscoverPageStateWidget --- FDiscoverDispose
    DiscoverPageStateWidget --- FDiscoverBuild
    DiscoverPageStateWidget --- FDiscoverRunSearch
    CategorySheetFunction --- RDisplays --- Car

    FShowroomBuild("build")
    FShowroomOpenCarSheet("_openCarSheet")
    ShowroomPageWidget --- FShowroomBuild
    ShowroomPageWidget --- FShowroomOpenCarSheet

    FCheckoutDispose("dispose")
    FCheckoutBuild("build")
    FCheckoutPickDate("_pickDate")
    FCheckoutPickTime("_pickTime")
    FCheckoutGroupItems("_groupItems")
    FCheckoutFormatPrice("_formatPrice")
    CheckoutPageStateWidget --- FCheckoutDispose
    CheckoutPageStateWidget --- FCheckoutBuild
    CheckoutPageStateWidget --- FCheckoutPickDate
    CheckoutPageStateWidget --- FCheckoutPickTime
    CheckoutPageStateWidget --- FCheckoutGroupItems
    CheckoutPageStateWidget --- FCheckoutFormatPrice

    FAdvisorDispose("dispose")
    FAdvisorBuild("build")
    FAdvisorSendMessage("_sendMessage")
    AdvisorChatPageStateWidget --- FAdvisorDispose
    AdvisorChatPageStateWidget --- FAdvisorBuild
    AdvisorChatPageStateWidget --- FAdvisorSendMessage

    FAllBuild("build")
    BrandPaneWidget --- FAllBuild
    LoginFormPaneWidget --- FAllBuild
    FeatureLineWidget --- FAllBuild
    SearchCardWidget --- FAllBuild
    SearchResultCardWidget --- FAllBuild
    SectionHeaderWidget --- FAllBuild
    ShowroomRailCardWidget --- FAllBuild
    ActivityCardWidget --- FAllBuild
    CategoryCardWidget --- FAllBuild
    SavedCarCardWidget --- FAllBuild
    DiscoverImageWidget --- FAllBuild
    InventoryRowWidget --- FAllBuild
    CounterButtonWidget --- FAllBuild
    ShowroomImageWidget --- FAllBuild
    FallbackArtWidget --- FAllBuild
    OrdersPageWidget --- FAllBuild
    SummaryDotWidget --- FAllBuild
    MessageBubbleWidget --- FAllBuild
    AccountPageWidget --- FAllBuild
    ColorChoiceWidget --- FAllBuild
    CarStoreScopeWidget --- FAllBuild
    CarStoreBackdropWidget --- FAllBuild
    GlowBlobWidget --- FAllBuild

    FTabFromQueryValue("fromQueryValue")
    FCarListingTitle("title getter")
    FDealerMessageFromJson("fromJson")
    FDealerMessageFromSnapshot("fromSnapshot")
    FDealerMessageToJson("toJson")
    FCarSearchResultsFromJson("fromJson")
    FCarSearchResultsToJson("toJson")
    FCarSearchResultFromJson("fromJson")
    FCarSearchResultToJson("toJson")
    CarStoreTabEnum --- FTabFromQueryValue
    CarListingModel --- FCarListingTitle
    DealerMessageModel --- FDealerMessageFromJson
    DealerMessageModel --- FDealerMessageFromSnapshot
    DealerMessageModel --- FDealerMessageToJson
    CarSearchResultsModel --- FCarSearchResultsFromJson
    CarSearchResultsModel --- FCarSearchResultsToJson
    CarSearchResultModel --- FCarSearchResultFromJson
    CarSearchResultModel --- FCarSearchResultToJson

    FOpenConnection("openCarStoreConnection")
    FOpenMemoryConnection("openCarStoreMemoryConnection")
    DriftConnectionEntity --- FOpenConnection
    DriftConnectionEntity --- FOpenMemoryConnection
```
