Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2B3822CE
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhEQCeV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:21 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44977 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhEQCeU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:20 -0400
Received: by mail-pf1-f182.google.com with SMTP id 22so3558623pfv.11
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEm0VkDELCCVZA8jXceu1efKCQnTnSl7+Cx9bupm+XI=;
        b=p5TR464NAF46/HOwmvdtHglRoif3fwW6CxidqQpeWl8g7hx9IaWhZxrURYHEVys0I2
         2dD8fw3aL8UqeT/qLYAHXszrJCJYgGr4KdtVsRazL3t5v4oSJydOYMsZmWxtER06qcJP
         nTOOrn4Hfj9RPW4aYnf4MV2kOkHSWPEV2Dr5guCrYwvv/BW0jg6iqtoI2Piy84wSfowE
         dK/JEX9dqko4nGjjeeNuBaho6WysI5jA8IyFaJG728JYOGGpVK71IeT/mApChTGFqcVN
         +/Ta+WfKMWTf6azIf1HXUiY5r5fpba4Oo4mqkdevDliKYJ+ppTU7kQvbUnAPdUDq7PeW
         HcKQ==
X-Gm-Message-State: AOAM532IIgAdN25eHg2Ht/VKz7hZU7X4ZcF/Tw3j9aqO9qF9xXIMA9cB
        jeJ51nOL8diKSVI0Fi6JIrQ=
X-Google-Smtp-Source: ABdhPJxVLTWzkSMXEGdIZr7W34QbcI9onWvjeSZxQNqpGMYQ4+K4bzPulkww2DKxTJKErYAZYo50AQ==
X-Received: by 2002:a63:935b:: with SMTP id w27mr28826615pgm.264.1621218784044;
        Sun, 16 May 2021 19:33:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j189sm8769596pfd.21.2021.05.16.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:33:03 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 12/12] fpga: m10bmc-sec: add max10 get_hw_errinfo callback func
Date:   Sun, 16 May 2021 19:32:00 -0700
Message-Id: <20210517023200.52707-13-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the MAX10 BMC Secure Update driver to include
a function that returns 64 bits of additional HW specific
data for errors that require additional information.
This callback function enables the hw_errinfo sysfs
node in the Intel Security Manager class driver.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/intel-m10-bmc-secure.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 9d45312001a3..bdf87ec125fe 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -483,11 +483,33 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
 	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
 }
 
+#define HW_ERRINFO_POISON	GENMASK(31, 0)
+static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	u32 auth_result = HW_ERRINFO_POISON;
+	u32 doorbell = HW_ERRINFO_POISON;
+
+	switch (smgr->err_code) {
+	case FPGA_SEC_ERR_HW_ERROR:
+	case FPGA_SEC_ERR_TIMEOUT:
+	case FPGA_SEC_ERR_BUSY:
+	case FPGA_SEC_ERR_WEAROUT:
+		m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result);
+
+		return (u64)doorbell << 32 | (u64)auth_result;
+	default:
+		return 0;
+	}
+}
+
 static const struct fpga_sec_mgr_ops m10bmc_sops = {
 	.prepare = m10bmc_sec_prepare,
 	.write_blk = m10bmc_sec_write_blk,
 	.poll_complete = m10bmc_sec_poll_complete,
 	.cancel = m10bmc_sec_cancel,
+	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
 };
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
-- 
2.31.1

