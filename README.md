# AlertUtils

A easy way to show your custom alert.



## NormalAlertUtils 
Alert Controller, it will allways present alert in front of UIViewcontroller, same display lavel with system alert.


## BasicAlert 
A basic class to create a alert with xib, all custom controller should inherit it.
 
    func normalPopview(){
        let alert = NormalTextAlert.init()
        alert.setMessage(text: "hello")
        //add alert button
        alert.addButton(text: "ok", textColor: .blue) {[unowned self] in
            nextPopview()
        }
        alert.addButton(text: "cancel", textColor: .blue) {
            //dismiss all alert
            NormalAlertUtils.shared().dismiss()
        }
        //show the alert
        NormalAlertUtils.shared().show(alert: alert)
    }
    
    func nextPopview(){
        let alert = NormalTextAlert.init()
        alert.setMessage(text: "next popview")
        alert.addButton(text: "ok", textColor: .blue) {
            //dismiss current alert
            NormalAlertUtils.shared().dismiss(alert: alert)
        }
        NormalAlertUtils.shared().show(alert: alert)
    }
