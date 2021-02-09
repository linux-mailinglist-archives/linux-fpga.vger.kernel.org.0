Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8331595A
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhBIWWd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Feb 2021 17:22:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:20938 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233882AbhBIWJB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:01 -0500
IronPort-SDR: IB2j+lJwfkMt5sYzgCrxiwHAEivFcV6mojwQpFFGxSIP+f/Vc0B1bpSlG/LBJphPH0Jl8yi6Sk
 Pc+SE4jRsNzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201058926"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="201058926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:12 -0800
IronPort-SDR: VPHwMfgBuAlCwDJCpfUhmnk/C2n2zxmBy/HR2WDRRHn1q8haKLE7wQVbs3QH1lNWfSjPIkA3aX
 LtUhJf3An+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959989"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:11 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 7/7] fpga: stratix10-soc: extend driver for bitstream authentication
Date:   Tue,  9 Feb 2021 16:20:33 -0600
Message-Id: <1612909233-13867-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend FPGA manager driver to support FPGA bitstream authentication on
Intel SocFPGA platforms.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v5: no change
v4: s/FPGA_MGR_BITSTREM_AUTHENTICATION/FPGA_MGR_BITSTREAM_AUTHENTICATE
v3: add handle to retriev the firmware version to keep driver
    back compatible
v2: use flag defined in stratix10-svc driver
---
 drivers/fpga/stratix10-soc.c | 62 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c..9ab7afd 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -24,6 +24,10 @@
 #define S10_BUFFER_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_BUFFER_TIMEOUT_MS))
 #define S10_RECONFIG_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_REQUEST_TIMEOUT_MS))
 
+#define INVALID_FIRMWARE_VERSION	0xFFFF
+typedef void (*s10_callback)(struct stratix10_svc_client *client,
+			     struct stratix10_svc_cb_data *data);
+
 /*
  * struct s10_svc_buf
  * buf:  virtual address of buf provided by service layer
@@ -40,11 +44,13 @@ struct s10_priv {
 	struct completion status_return_completion;
 	struct s10_svc_buf svc_bufs[NUM_SVC_BUFS];
 	unsigned long status;
+	unsigned int fw_version;
 };
 
 static int s10_svc_send_msg(struct s10_priv *priv,
 			    enum stratix10_svc_command_code command,
-			    void *payload, u32 payload_length)
+			    void *payload, u32 payload_length,
+			    s10_callback callback)
 {
 	struct stratix10_svc_chan *chan = priv->chan;
 	struct device *dev = priv->client.dev;
@@ -57,6 +63,7 @@ static int s10_svc_send_msg(struct s10_priv *priv,
 	msg.command = command;
 	msg.payload = payload;
 	msg.payload_length = payload_length;
+	priv->client.receive_cb = callback;
 
 	ret = stratix10_svc_send(chan, &msg);
 	dev_dbg(dev, "stratix10_svc_send returned status %d\n", ret);
@@ -134,6 +141,29 @@ static void s10_unlock_bufs(struct s10_priv *priv, void *kaddr)
 }
 
 /*
+ * s10_fw_version_callback - callback for the version of running firmware
+ * @client: service layer client struct
+ * @data: message from service layer
+ */
+static void s10_fw_version_callback(struct stratix10_svc_client *client,
+				    struct stratix10_svc_cb_data *data)
+{
+	struct s10_priv *priv = client->priv;
+	unsigned int *version = (unsigned int *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK))
+		priv->fw_version = *version;
+	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev,
+			 "FW doesn't support bitstream authentication\n");
+	else
+		dev_err(client->dev, "Failed to get FW version %lu\n",
+			BIT(data->status));
+
+	complete(&priv->status_return_completion);
+}
+
+/*
  * s10_receive_callback - callback for service layer to use to provide client
  * (this driver) messages received through the mailbox.
  * client: service layer client struct
@@ -186,13 +216,22 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
 		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+	} else if (info->flags & FPGA_MGR_BITSTREAM_AUTHENTICATE) {
+		if (priv->fw_version == INVALID_FIRMWARE_VERSION) {
+			dev_err(dev, "FW doesn't support\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(dev, "Requesting bitstream authentication.\n");
+		ctype.flags |= BIT(COMMAND_AUTHENTICATE_BITSTREAM);
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
 	}
 
 	reinit_completion(&priv->status_return_completion);
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
-			       &ctype, sizeof(ctype));
+			       &ctype, sizeof(ctype),
+			       s10_receive_callback);
 	if (ret < 0)
 		goto init_done;
 
@@ -259,7 +298,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
 	svc_buf = priv->svc_bufs[i].buf;
 	memcpy(svc_buf, buf, xfer_sz);
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
-			       svc_buf, xfer_sz);
+			       svc_buf, xfer_sz, s10_receive_callback);
 	if (ret < 0) {
 		dev_err(dev,
 			"Error while sending data to service layer (%d)", ret);
@@ -303,7 +342,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 
 			ret = s10_svc_send_msg(
 				priv, COMMAND_RECONFIG_DATA_CLAIM,
-				NULL, 0);
+				NULL, 0, s10_receive_callback);
 			if (ret < 0)
 				break;
 		}
@@ -357,7 +396,8 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	do {
 		reinit_completion(&priv->status_return_completion);
 
-		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS, NULL, 0);
+		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS,
+				       NULL, 0, s10_receive_callback);
 		if (ret < 0)
 			break;
 
@@ -411,8 +451,9 @@ static int s10_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->fw_version = INVALID_FIRMWARE_VERSION;
 	priv->client.dev = dev;
-	priv->client.receive_cb = s10_receive_callback;
+	priv->client.receive_cb = NULL;
 	priv->client.priv = priv;
 
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -440,6 +481,15 @@ static int s10_probe(struct platform_device *pdev)
 		goto probe_err;
 	}
 
+	/* get the running firmware version */
+	ret = s10_svc_send_msg(priv, COMMAND_FIRMWARE_VERSION,
+			       NULL, 0, s10_fw_version_callback);
+	if (ret) {
+		dev_err(dev, "couldn't get firmware version\n");
+		fpga_mgr_free(mgr);
+		goto probe_err;
+	}
+
 	platform_set_drvdata(pdev, mgr);
 	return ret;
 
-- 
2.7.4

