package loan.atrinatechnologies.lms

import com.google.firebase.inappmessaging.FirebaseInAppMessagingClickListener
import com.google.firebase.inappmessaging.model.Action
import com.google.firebase.inappmessaging.model.CampaignMetadata
import com.google.firebase.inappmessaging.model.InAppMessage


class MyClickListner : FirebaseInAppMessagingClickListener {

    override fun messageClicked(inAppMessage: InAppMessage, action: Action) {
        // Determine which URL the user clicked
        val url: String? = action.getActionUrl()

        // Get general information about the campaign
        val metadata: CampaignMetadata? = inAppMessage.getCampaignMetadata()
    }
}