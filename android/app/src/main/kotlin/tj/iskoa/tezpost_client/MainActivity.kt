package tj.iskoa.tezpost_client

import android.content.Intent
import android.net.Uri
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "tj.iskoa.tezpost_client/phone"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "makePhoneCallChooser" -> {
                    val phoneNumber = call.arguments as String
                    makePhoneCallChooser(phoneNumber)
                    result.success(null)
                }
                "openWhatsApp" -> {
                    val phoneNumber = call.arguments as String
                    openWhatsApp(phoneNumber, result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun makePhoneCallChooser(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_DIAL)
        intent.data = Uri.parse("tel:$phoneNumber")
        val chooser = Intent.createChooser(intent, "Выберите приложение для звонка")
        startActivity(chooser)
    }

    private fun openWhatsApp(phoneNumber: String, result: MethodChannel.Result) {
        try {
            val uri = Uri.parse("https://wa.me/$phoneNumber")
            val intent = Intent(Intent.ACTION_VIEW, uri)
            intent.setPackage("com.whatsapp")
            startActivity(intent)
            result.success(null)
        } catch (e: Exception) {
            result.error("WHATSAPP_ERROR", "Не удалось открыть WhatsApp: ${e.localizedMessage}", null)
        }
    }
}
