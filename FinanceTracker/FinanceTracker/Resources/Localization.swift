//
//  Localization.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 13.03.2022.
//

import Foundation

struct Localization {
    enum Common: String {
        case back = "Назад"
        case buyHeaderLabel = "Детали"
        case dateSubtitleLabel = "Дата покупки"
        case addDescriptionPlaceHolder = "Добавление"
        case removeDescriptionPlaceHolder = "Удаление"
    }
    
    enum Stocks: String {
        case stocksPlaceHolderImage = "stocksTemp"
        case stocksPlaceHolderTitle = "Осуществите поиск акций\nдля расчёта потенциальной доходности"
        case stocksSearchBarPlaceholder = "Введите название компании"
        case stocksTitle = "Акции"
        case stockHistory = "История\nизменений"
        
        enum History: String {
            case priceSubtitleLabel = "Цена приобретения бумаги"
            case lotsCountSubtitleLabel = "Количество лотов"
        }
    }
    
    enum Crypto: String {
        case cryptoTitle = "Криптовалюта"
        case cryptoSearchBarPlaceholder = "Введите название криптовалюты"
        case cryptoPlaceHolderImage = "cryptoTemp"
        case cryptoPlaceHolderTitle = "Добавьте криптовалюту,\nесли она имеет место в вашей жизни"
        
        enum History: String {
            case priceSubtitleLabel = "Цена приобретения криптовалюты"
            case lotsCountSubtitleLabel = "Количество"
        }
    }
    
    enum Money: String {
        case moneyPlaceHolderImage = "moneyTemp"
        case moneyPlaceHolderTitle = "Внесите доходы и расходы,\nучитывая необходимые категории"
        case moneyTitle = "Доходы / Расходы"
        
        enum Details: String {
            case category = "Категория"
            case sum = "Сумма дохода / траты"
            case date = "Дата"
        }
    }
    
    enum Statistics: String {
        case statisticsPlaceHolderImage = "statisticsTemp"
        case statisticsPlaceHolderTitle = "Здесь будет отображена\nстатистика по всем активам"
    }
}
