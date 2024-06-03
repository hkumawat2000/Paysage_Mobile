package com.atrina.lms

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterView
import io.flutter.Log
import java.util.ArrayList
import android.accounts.AccountManager;
import android.accounts.Account;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterFragmentActivity
import android.content.Intent
import com.google.firebase.inappmessaging.FirebaseInAppMessagingClickListener
import com.google.firebase.inappmessaging.model.Action
import com.google.firebase.inappmessaging.model.CampaignMetadata
import com.google.firebase.inappmessaging.model.InAppMessage
import com.google.firebase.inappmessaging.FirebaseInAppMessaging
import com.atrina.lms.MyClickListner


class MainActivity : FlutterFragmentActivity () {
    private val CHANNEL = "samples.flutter.io/email"

    fun addClickListener() {
        val listener = MyClickListner()
        FirebaseInAppMessaging.getInstance().addClickListener(listener)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

//        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.equals("getEmailList")) {
                        val list: List<String> = java.util.ArrayList()
                        val manager: AccountManager = AccountManager.get(getApplicationContext())
                        val accounts: Array<Account> = manager.getAccountsByType("com.google")
                        val possibleEmails: MutableList<String> = java.util.ArrayList()
                        for (account in accounts) {
                            possibleEmails.add(account.name)
                        }
                        /*Pattern emailPattern = Patterns.EMAIL_ADDRESS; // API level 8+
                                    Account[] accounts = AccountManager.get(getApplicationContext()).getAccounts();
                                    for (Account account : accounts) {
                                        if (emailPattern.matcher(account.name).matches()) {
                                            primaryEmail = account.name;
                                        }
                                    }*/
                        result.success(possibleEmails)
                    } else if (call.method.equals("openJiffy")) {
                        try {
                             var intent = Intent()
                             intent = packageManager.getLaunchIntentForPackage("com.choiceequitybroking.jiffy")!!
                             startActivity(intent)
                             result.success(true);
                        } catch (e: Exception) {
                            android.util.Log.d("Failed to Open Jiffy App", e.toString())
                            result.success(false);
                        }
                    }
                }
    }
}

