//
//  CoinDetail.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import Foundation

struct CoinDetail: Codable {
    let id: ID?
    let symbol, name: String?
    let webSlug: ID?
    let assetPlatformID: String?
    let platforms: Platforms?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let publicNotice: String?
    let additionalNotices: [String]?
    let localization, description: CoinNameLocalize?
    let links: Links?
    let image: CoinImage?
    let countryOrigin, genesisDate: String?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
    let watchlistPortfolioUsers, marketCapRank: Int?
    let marketData: Coin?
    let communityData: CommunityData?
    let lastUpdated: String?
    let tickers: [Ticker]?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case assetPlatformID = "asset_platform_id"
        case platforms
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case localization, description, links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case communityData = "community_data"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - CommunityData
struct CommunityData: Codable {
    let facebookLikes: Int?
    let twitterFollowers, redditAveragePosts48H, redditAverageComments48H, redditSubscribers: Int?
    let redditAccountsActive48H: Int?
    let telegramChannelUserCount: Int?

    enum CodingKeys: String, CodingKey {
        case facebookLikes = "facebook_likes"
        case twitterFollowers = "twitter_followers"
        case redditAveragePosts48H = "reddit_average_posts_48h"
        case redditAverageComments48H = "reddit_average_comments_48h"
        case redditSubscribers = "reddit_subscribers"
        case redditAccountsActive48H = "reddit_accounts_active_48h"
        case telegramChannelUserCount = "telegram_channel_user_count"
    }
}

// MARK: - Tion
struct CoinNameLocalize: Codable {
    let en, de, es, fr: String?
    let it, pl, ro, hu: String?
    let nl, pt, sv, vi: String?
    let tr, ru, ja, zh: String?
    let zhTw, ko, ar, th: String?
    let id, cs, da, el: String?
    let hi, no, sk, uk: String?
    let he, fi, bg, hr: String?
    let lt, sl: String?

    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}

enum ID: String, Codable {
    case avalanche2 = "avalanche-2"
    case binancecoin = "binancecoin"
    case bitcoin = "bitcoin"
    case ethereum = "ethereum"
    case solana = "solana"
    case wrappedBitcoin = "wrapped-bitcoin"
    case zcash = "zcash"
}

// MARK: - Image
struct CoinImage: Codable {
    let thumb, small, large: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let whitepaper: String?
    let blockchainSite, officialForumURL: [String]?
    let chatURL, announcementURL: [String]?
    let twitterScreenName: ID?
    let facebookUsername: String?
    let bitcointalkThreadIdentifier: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    let reposURL: ReposURL?

    enum CodingKeys: String, CodingKey {
        case homepage, whitepaper
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
    }
}

// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]?
    let bitbucket: [String]?
}

// MARK: - Platforms
struct Platforms: Codable {
    let empty: String?

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - Ticker
struct Ticker: Codable {
    let last, volume: Double?
    let convertedLast, convertedVolume: [String: Double]?
    let trustScore: TrustScore?
    let bidAskSpreadPercentage: Double?
    let timestamp, lastTradedAt, lastFetchAt: Date?
    let isAnomaly, isStale: Bool?
    let tradeURL: String?
    let tokenInfoURL: String?
    let coinID: ID?

    enum CodingKeys: String, CodingKey {
        case last, volume
        case convertedLast = "converted_last"
        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeURL = "trade_url"
        case tokenInfoURL = "token_info_url"
        case coinID = "coin_id"
    }
}

enum TrustScore: String, Codable {
    case green = "green"
}
