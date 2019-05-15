//
//  AccessibilityIdentitier.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

enum AccessibilityIdentitier {
    
    enum Splash {
        static let rootView = "Splash_RootView"
    }
    
    enum Menu {
        static let rootView = "Menu_RootView"
        static let pizzaCellFormat = "Menu_Pizza_Cell_%@"
        static let pizzaCellTitle = "Menu_Pizza_Cell_Title"
        static let pizzaCellPrice = "Menu_Pizza_Cell_Price"
    }
    
    enum Order {
        
        enum CommonButton {
            static let backButton = "Order_CommonButton_BackButton"
            static let closeButton = "Order_CommonButton_CloseButton"
            static let nextButton = "Order_CommonButton_NextButton"
        }
        
        enum SelectAddress {
            static let rootView = "SelectAddress_RootView"
            static let streetInput = "SelectAddress_streetInput"
            static let buildingInput = "SelectAddress_buildingInput"
        }
        
        enum EnterDeliveryDetails {
            static let rootView = "EnterDeliveryDetails_RootView"
            static let nameInput = "EnterDeliveryDetails_nameInput"
            static let phoneNumberInput = "EnterDeliveryDetails_phoneNUmberInput"
            static let streetInput = "EnterDeliveryDetails_streetInput"
            static let buildingInput = "EnterDeliveryDetails_buildingInput"
            static let entranceInput = "EnterDeliveryDetails_entranceInput"
            static let ataprtmentInput = "EnterDeliveryDetails_ataprtmentInput"
            static let floorInput = "EnterDeliveryDetails_floorInput"
            static let commentInput = "EnterDeliveryDetails_commentInput"
        }
        
        enum SelectPaymentMethod {
            static let rootView = "SelectPaymentMethod_RootView"
            static let totalSumLabel = "SelectPaymentMethod_totalSumLabel"
            static let cashSegmentLabel = "SelectPaymentMethod_cashSegmentLabel"
            static let cardSegmentLabel = "SelectPaymentMethod_cardSegmentLabel"
            static let cashAmountInput = "SelectPaymentMethod_cashAmountInput"
        }
        
        enum ConfirmOrder {
            static let rootView = "ConfirmOrder_RootView"
            static let totalSumLabel = "ConfirmOrder_totalSumLabel"
            static let nameValueLabel = "ConfirmOrder_nameInput"
            static let pizzaTitleValueLabel = "ConfirmOrder_pizzaTitleValueLabel"
            static let phoneNumberValueLabel = "ConfirmOrder_phoneNUmberInput"
            static let addressValueLabel = "ConfirmOrder_addressValueLabel"
            static let commentValueLabel = "ConfirmOrder_commentValueLabel"
            static let paymentMethodValueLabel = "ConfirmOrder_paymentMethodValueLabel"
            static let confirmButton = "ConfirmOrder_ConfirmButton"
        }
        
        enum OrderSuccessScreen {
            static let rootView = "OrderSuccessScreen_RootView"
            static let finishButton = "OrderSuccessScreen_Finish"
        }
    }
    
    enum CommonInputControl {
        static let value = "CommonInputControl_Value"
        static let picker = "CommonInputControl_picker"
        static let pickerDoneButton = "CommonInputControl_pickerDoneButton"
        static let pickerCancelButton = "CommonInputControl_pickerCancelButton"
        
        static let keyboardDoneButton = "Done"
    }
    
    static let activityIndicator = "activity_indicator"

}
