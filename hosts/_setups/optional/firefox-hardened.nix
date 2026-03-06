{ pkgs, ... }: {
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-esr;

        # Reference: <https://mozilla.github.io/policy-templates/>
        policies = {
            "AutofillAddressEnabled" = false;
            "AutofillCreditCardEnabled" = false;
            "Cookies" = {
                "Allow" = [];
                "AllowSession" = [];
                "BehaviorPrivateBrowsing" = "reject-tracker-and-partition-foreign";
                "Behavior" = "reject-tracker-and-partition-foreign";
                "Block" = [];
                "Locked" = true;
            };
            "DisableFirefoxAccounts" = true;
            "DisableFirefoxStudies" = true;
            "DisableFormHistory" = true;
            "DisablePocket" = true;
            "DisableSetDesktopBackground" = true;
            "DisableTelemetry" = true;
            "DisplayBookmarksToolbar" = "never";
            "DontCheckDefaultBrowser" = true;
            "EnableTrackingProtection" = {
                "Cryptomining" = true;
                "Exceptions" = [];
                "Fingerprinting" = true;
                "Locked" = true;
                "Value" = true;
            };
            "FirefoxSuggest" = {
                "ImproveSuggest" = false;
                "Locked" = true;
                "SponsoredSuggestions" = false;
                "WebSuggestions" = false;
            };
            "NoDefaultBookmarks" = true;
            "Permissions" = {
                "Autoplay" = {
                    "Allow" = [];
                    "Block" = [];
                    "Default" = "block-audio-video";
                    "Locked" = true;
                };
                "Camera" = {
                    "Allow" = [];
                    "Block" = [];
                    "BlockNewRequests" = true;
                    "Locked" = false;
                };
                "Location" = {
                    "Allow" = [];
                    "Block" = [];
                    "BlockNewRequests" = true;
                    "Locked" = true;
                };
                "Microphone" = {
                    "Allow" = [];
                    "Block" = [];
                    "BlockNewRequests" = true;
                    "Locked" = false;
                };
                "Notifications" = {
                    "Allow" = [];
                    "Block" = [];
                    "BlockNewRequests" = true;
                    "Locked" = true;
                };
            };
            "PopupBlocking" = {
                "Allow" = [];
                "Default" = true;
                "Locked" = true;
            };
            "SearchSuggestEnabled" = false;
        };

        # The status of `firefox.preferences`:
        #   - "default"     - Preferences appear as default
        #   - "locked"      - (default) Preferences appear as default and can’t be changed
        #   - "user"        - Preferences appear as changed
        #   - "clear"       - Value has no effect. Resets to factory defaults on each startup
        preferencesStatus = "locked";

        # Preferences to set from `about:config`
        # Some of these might be able to be configured more ergonomically using policies
        # When this option is in use, Firefox will inform you that "your browser
        #   is managed by your organisation"
        # That message appears because NixOS installs what you have declared here
        #   such that it cannot be overridden through the user interface
        # It does not mean that someone else has been given control of your browser,
        #   unless of course they also control your NixOS configuration
        # NOTES:
        #   - These will be placed under `policies.preferences` (<https://mozilla.github.io/policy-templates/#preferences>)
        preferences = {
            "alerts.useSystemBackend" = false;
            "alerts.useSystemBackend.windows.notificationserver.enabled" = false;
            "app.normandy.api_url" = "";
            "app.normandy.enabled" = false;
            "app.shield.optoutstudies.enabled" = false;
            "beacon.enabled" = false;

            # Source:
            #   - <https://gist.github.com/gagarine/5cf8f861abe0dd035b7af19e4f691cd8>
            #   - <https://bugzilla.mozilla.org/show_bug.cgi?id=1304389>
            #
            # This fixes Firefox's freezes on startup because of too much read/write
            # It will only use RAM for cache, so reloading websites after Firefox restarts can be a bit slower if the network is slow
            "browser.cache.disk.enable" = false;

            "browser.cache.offline.enable" = false;
            "browser.casting.enabled" = false;
            "browser.contentanalysis.default_allow" = false;
            "browser.contentanalysis.default_result" = 0;
            "browser.contentanalysis.enabled" = false;
            "browser.contentblocking.category" = "strict";
            "browser.discovery.enabled" = false;
            "browser.dom.window.dump.enabled" = false;
            "browser.download.forbid_open_with" = true;
            "browser.download.manager.scanWhenDone" = true;
            "browser.download.useDownloadDir" = false;
            "browser.firefox-view.feature-tour" = ''{"screen":"","complete":true}'';
            "browser.firefox-view.search.enabled" = false;
            "browser.firefox-view.virtual-list.enabled" = false;
            "browser.newtabpage.activity-stream.asrouter.useruser_prefs.cfr" = false;
            "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
            "browser.newtabpage.activity-stream.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.weatherfeed" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.newtabpage.activity-stream.weather.locationSearchEnabled" = false;
            "browser.pagethumbnails.capturing_disabled" = true;
            "browser.ping-centre.telemetry" = false;
            "browser.places.speculativeConnect.enabled" = false;
            "browser.pocket.enabled" = false;
            "browser.preferences.moreFromMozilla" = false;
            "browser.privatebrowsing.promoEnabled" = false;
            "browser.promo.cookiebanners.enabled" = true;
            "browser.promo.focus.enabled" = false;
            "browser.promo.pin.enabled" = false;
            "browser.region.network.url" = "";
            "browser.region.update.enabled" = false;
            "browser.safebrowsing.downloads.enabled" = true;
            "browser.safebrowsing.downloads.remote.enabled" = true;
            "browser.safebrowsing.malware.enabled" = true;
            "browser.safebrowsing.phishing.enabled" = true;
            "browser.search.serpEventTelemetryCategorization.enabled" = false;
            "browser.search.serpEventTelemetry.enabled" = false;
            "browser.search.serpMetricsRecordedCounter" = 0;
            "browser.search.suggest.enabled" = false;
            "browser.search.suggest.enabled.private" = false;
            "browser.search.widget.inNavBar" = false;
            "browser.send_pings" = false;
            "browser.sessionstore.max_tabs_undo" = 10;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.shortcutFavicons" = false;
            "browser.shopping.experience2023.enabled" = false;
            "browser.tabs.closeButtons" = 1;
            "browser.tabs.firefox-view" = false;
            "browser.tabs.firefox-view-newIcon" = false;
            "browser.tabs.firefox-view-next" = false;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.topsites.contile.enabled" = false;
            "browser.uitour.enabled" = false;
            "browser.uitour.url" = "";
            "browser.urlbar.addons.featureGate" = false;
            "browser.urlbar.clickSelectsAll" = false;
            "browser.urlbar.clipboard.featureGate" = false;
            "browser.urlbar.doubleClickSelectsAll" = false;
            "browser.urlbar.maxRichResults" = 20;
            "browser.urlbar.mdn.featureGate" = false;
            "browser.urlbar.merino.endpointURL" = "";
            "browser.urlbar.pocket.featureGate" = false;
            "browser.urlbar.quicksuggest.contextualOptIn" = false;
            "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
            "browser.urlbar.quicksuggest.enabled" = false;
            "browser.urlbar.recentsearches.featureGate" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.urlbar.showSearchTerms.enabled" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.pocket" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.trending" = false;
            "browser.urlbar.suggest.weather" = false;
            "browser.urlbar.suggest.yelp" = false;
            "browser.urlbar.trending.featureGate" = false;
            "browser.urlbar.trimURLs" = false;
            "browser.urlbar.weather.featureGate" = false;
            "browser.urlbar.yelp.featureGate" = false;
            "browser.vpn_promo.enabled" = false;
            "captivedetect.canonicalURL" = "";
            "clipboard.autocopy" = false;
            "cookiebanners.service.mode" = 2;
            "cookiebanners.service.mode.privateBrowsing" = 2;
            "corroborator.enabled" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "default-browser-agent.enabled" = false;
            "devtools.debugger.remote-enabled" = false;
            "dom.prefetch_dns_for_anchor_http_document" = false;
            "dom.prefetch_dns_for_anchor_https_document" = false;
            "dom.private-attribution.submission.enabled" = false;
            "dom.push.connection.enabled" = false;
            "dom.push.enabled" = false;
            "dom.push.serverURL" = "";
            "dom.security.unexpected_system_load_telemetry_enabled" = false;
            "dom.telephony.enabled" = false;
            "dom.vr.enabled" = false;
            "dom.vr.process.enabled" = false;
            "dom.webnotifications.enabled" = false;
            "dom.webnotifications.privateBrowsing.enabled" = false;
            "dom.webnotifications.serviceworker.enabled" = false;
            "experiments.enabled" = false;
            "extensions.experiments.enabled" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.available" = "off";
            "extensions.formautofill.creditCards.enabled" = false;
            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.discover.enabled" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "extensions.pocket.api" = "";
            "extensions.pocket.enabled" = false;
            "extensions.pocket.site" = "";
            "extensions.quarantinedDomains.enabled" = true;
            "extensions.recommendations.hideNotice" = true;
            "extensions.shield-recipe-client.enabled" = false;
            "extensions.update.enabled" = true;
            "extensions.webextensions.restrictedDomains" = "";
            "general.oscpu.override" = "Windows NT 10.0; Win64; x64";
            "general.platform.override" = "Win32";
            "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0";
            "geo.enabled" = false;
            "geo.wifi.uri" = "";
            "identity.fxaccounts.enabled" = false;
            "identity.fxaccounts.telemetry.clientAssociationPing.enabled" = false;
            "intl.accept_languages" = "en-US, en";
            "javascript.use_us_english_locale" = true;
            "layout.spellcheckDefault" = 2;
            "media.autoplay.default" = 5;
            "media.hardwaremediakeys.enabled" = false;
            "media.peerconnection.enabled" = false;
            "media.videocontrols.picture-in-picture.enabled" = false;
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
            "middlemouse.paste" = false;
            "network.captive-portal-service.enabled" = false;
            "network.connectivity-service.DNS_HTTPS.domain" = "";
            "network.connectivity-service.enabled" = false;
            "network.cookie.cookieBehavior" = 5;
            "network.cookie.cookieBehavior.pbmode" = 5;
            "network.cookie.lifetimePolicy" = 0;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.dns.disablePrefetch" = true;
            "network.dns.prefetch_via_proxy" = false;
            "network.http.speculative-parallel-limit" = 0;
            "network.IDN_show_punycode" = true;
            "network.jar.open-unsafe-types" = false;
            "network.preconnect" = false;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.prefetch-next" = false;
            "network.trr.ohttp.config_uri" = "";
            "network.trr.ohttp.relay_uri" = "";
            "network.trr.ohttp.uri" = "";
            "network.trr.use_ohttp" = false;
            "pdfjs.enableScripting" = false;
            "permissions.default.camera" = 2;
            "permissions.default.desktop-notification" = 2;
            "permissions.default.geo" = 2;
            "permissions.default.microphone" = 2;
            "permissions.default.xr" = 2;
            "permissions.delegation.enabled" = false;
            "permissions.manager.defaultsUrl" = "";
            "places.history.enabled" = false;
            "places.history.floodingPrevention.enabled" = true;
            "privacy.bounceTrackingProtection.enabled" = true;
            "privacy.bounceTrackingProtection.hasMigratedUserActivationData" = true;
            "privacy.clearHistory.cache" = true;
            "privacy.clearHistory.cookiesAndStorage" = true;
            "privacy.clearHistory.historyFormDataAndDownloads" = false;
            "privacy.clearHistory.siteSettings" = true;
            "privacy.clearOnShutdown.cache" = true;
            "privacy.clearOnShutdown.cookies" = true;
            "privacy.clearOnShutdown.formdata" = true;
            "privacy.clearOnShutdown.history" = true;
            "privacy.clearOnShutdown.offlineApps" = true;
            "privacy.clearOnShutdown.openWindows" = false;
            "privacy.clearOnShutdown.sessions" = true;
            "privacy.clearOnShutdown.siteSettings" = false;
            "privacy.clearOnShutdown_v2.cache" = true;
            "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
            "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
            "privacy.clearOnShutdown_v2.siteSettings" = false;
            "privacy.clearSiteData.cache" = true;
            "privacy.clearSiteData.cookiesAndStorage" = true;
            "privacy.clearSiteData.historyFormDataAndDownloads" = true;
            "privacy.clearSiteData.siteSettings" = false;
            "privacy.cpd.cookies" = false;
            "privacy.cpd.formdata" = true;
            "privacy.cpd.history" = true;
            "privacy.cpd.offlineApps" = false;
            "privacy.cpd.sessions" = true;
            # "privacy.fingerprintingProtection.overrides" = "-AllTargets,+CSSDeviceSize,+FontVisibilityBaseSystem,+MediaDevices,+SpeechSynthesis,+WebGLRenderInfo,+JSLocale,+NavigatorHWConcurrency";
            "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
            "privacy.fingerprintingProtection.pbmode" = true;
            "privacy.fingerprintingProtection.remoteOverrides.enabled" = false;
            "privacy.fingerprintingProtection" = true;
            "privacy.firstparty.isolate" = true;
            "privacy.history.custom" = true;
            "privacy.resistFingerprinting.pbmode" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs2" = true;
            "privacy.sanitize.sanitizeOnShutdown" = true;
            "privacy.sanitize.timeSpan" = 0;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            "privacy.trackingprotection.emailtracking.enabled" = true;
            "privacy.trackingprotection.emailtracking.pbmode.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.pbmode.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "security.family_safety.mode" = 0;
            "security.ssl.disable_session_identifiers" = true;
            "security.ssl.enable_false_start" = false;
            "security.ssl.require_safe_negotiation" = true;
            "security.ssl.treat_unsafe_negotiation_as_broken" = true;
            "signon.firefoxRelay.feature" = "disabled";
            "signon.formlessCapture.enabled" = false;
            "toolkit.coverage.endpoint.base" = "";
            "toolkit.coverage.opt-out" = true;
            "toolkit.shopping.ohttpConfigURL" = "";
            "toolkit.shopping.ohttpRelayURL" = "";
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.telemetry.dap_enabled" = false;
            "toolkit.telemetry.dap_helper" = "";
            "toolkit.telemetry.dap.helper.hpke" = "";
            "toolkit.telemetry.dap_helper_owner" = "";
            "toolkit.telemetry.dap.helper.url" = "";
            "toolkit.telemetry.dap_leader" = "";
            "toolkit.telemetry.dap.leader.hpke" = "";
            "toolkit.telemetry.dap_leader_owner" = "";
            "toolkit.telemetry.dap.leader.url" = "";
            "toolkit.telemetry.dap_task1_enabled" = false;
            "toolkit.telemetry.dap_visit_counting_enabled" = false;
            "toolkit.telemetry.dap_visit_counting_experiment_list" = "[]";
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.shutdownPingSender.backgroundtask.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabledFirstSession" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.user_characteristics_ping.opt-out" = true;
            "webgl.disabled" = false;
            "webgl.min_capability_mode" = true;
        };
    };
}
