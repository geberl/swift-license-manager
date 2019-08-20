//
//  ViewController.swift
//  DropPy License Manager
//
//  Created by Günther Eberl on 21.09.17.
//  Copyright © 2017 Günther Eberl. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var productTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var companyTextField: NSTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var licenseCodeTextField: NSTextField!
    @IBOutlet weak var regNameTextField: NSTextField!
    @IBOutlet weak var statusTextField: NSTextField!
    
    @IBAction func onGenerateButton(_ sender: NSButton) {
        let privateKey: String = self.privateKey()
        let regName: String = self.getRegName()
        var licenseCode: String? = nil
        
        if let generator = generatorWithPrivateKey(privateKey) {
            do {
                try licenseCode = generator.generate(regName)
                licenseCodeTextField.stringValue = licenseCode!
                statusTextField.stringValue = "License Code generated"
            } catch {
                statusTextField.stringValue = "Error: Unable to generating license code."
            }
        } else {
            statusTextField.stringValue = "Error: LicenseGenerator could not be constructed."
        }
    }
    
    @IBAction func onValidateButton(_ sender: NSButton) {
        let publicKey: String = self.publicKey()
        let regName: String = self.getRegName()
        let licenseCode: String = self.licenseCodeTextField.stringValue
        var validLicense: Bool = false
        
        if let verifier = verifierWithPublicKey(publicKey) {
            validLicense = verifier.verify(licenseCode, forName: regName)
        } else {
            statusTextField.stringValue = "Error: LicenseVerifier could not be constructed."
        }
        
        if validLicense {
            statusTextField.stringValue = "License Code VALID"
        } else {
            statusTextField.stringValue = "License Code INVALID"
        }
    }
    
    func getRegName() -> String {
        let product: String = self.productTextField.stringValue  // needed so a user doesn't get a license code that works on all your product when he buys one
        let name: String = self.nameTextField.stringValue
        let email: String = self.emailTextField.stringValue
        let company: String = self.companyTextField.stringValue
        let regName = product + "|" + name + "|" + email + "|" + company
        self.regNameTextField.stringValue = regName
        return regName
    }
    
    fileprivate func publicKey() -> String {
        var parts = [String]()
        parts.append("-----BEGIN PUBLIC KEY-----\n")
        parts.append("MIHwMIGoBgcqhkjOOAQBMIGcAkEA0na+2HrZFpHgSuPt3URJHdi1ZdYV\n")
        parts.append("LmynsU6hlJCc6ls1SEMAfvreHI2wjPLYsp/uGdry80fAfzJzc6sbAWAS\n")
        parts.append("WwIVAM8C9fTNlz2UG0s7cxBhwvZ/YQ2TAkAEq2QWgNT3PmjOBni47BF9\n")
        parts.append("z1BvfDihZgXapbTS/VoX2IRGPAqJD5z3n63DcP2/HR85OpAnh5EoJ2+A\n")
        parts.append("1KP+7PmPA0MAAkB6EewxQwgHzP57HuC2h1we7VxcsqoyiXofL9ADxSPf\n")
        parts.append("9CMfYDJVFgjiWGMEIui9a4GaPYl1EHPxilgYfDHJ0HtT\n")
        parts.append("-----END PUBLIC KEY-----\n")
        return parts.joined(separator: "")
    }
    
    fileprivate func privateKey() -> String {
        var parts = [String]()
        parts.append("-----BEGIN DSA PRIVATE KEY-----\n")
        parts.append("MIH4AgEAAkEA0na+2HrZFpHgSuPt3URJHdi1ZdYVLmynsU6hlJCc6ls1\n")
        parts.append("SEMAfvreHI2wjPLYsp/uGdry80fAfzJzc6sbAWASWwIVAM8C9fTNlz2U\n")
        parts.append("G0s7cxBhwvZ/YQ2TAkAEq2QWgNT3PmjOBni47BF9z1BvfDihZgXapbTS\n")
        parts.append("/VoX2IRGPAqJD5z3n63DcP2/HR85OpAnh5EoJ2+A1KP+7PmPAkB6Eewx\n")
        parts.append("QwgHzP57HuC2h1we7VxcsqoyiXofL9ADxSPf9CMfYDJVFgjiWGMEIui9\n")
        parts.append("a4GaPYl1EHPxilgYfDHJ0HtTAhUAsWZBduv3aFnYiRBii/R2CXQhoTg=\n")
        parts.append("-----END DSA PRIVATE KEY-----\n")
        return parts.joined(separator: "")
    }
    
    fileprivate func verifierWithPublicKey(_ publicKey: String) -> LicenseVerifier? {
        return LicenseVerifier(publicKeyPEM: publicKey)
    }
    
    fileprivate func generatorWithPrivateKey(_ privateKey: String) -> LicenseGenerator? {
        return LicenseGenerator(privateKeyPEM: privateKey)
    }
}
