Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48A4D74E2
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiCMK7o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiCMK63 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C1117776D;
        Sun, 13 Mar 2022 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169041; x=1678705041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkGpYCVnDBt3WyXwks8kIFpgzT6/MDg8eLb8oYB0Lkk=;
  b=DGRwBe+t554g7D9ng6nIKhhk12yjTLFL8PkAD+R8XhUkzeOJ4jsvRzvd
   fMW0UAR7ZXazkrY0SoKNqpvVarpvYoOwB87buyu5gbs0uBqnT6Fedzm9d
   1fDrkC2MFxUPUXG32otFrmNA4uMtXsj8cesDDg7Yrzwpj9yUqbDIiehe2
   6kf6h8rE/wp1ttS4jur/700H5+6jQ5zy02An5aM9Mvv6+EaRTdhuilT/2
   /Xy25rLc+JJ7SyK98ncWqtnz9uoYrVzTXXUhicUWtLJu8/IhjP/uab++x
   O4nnor+I2sdstJFEU+VePimLehcaaLHHOJWD8Hp/vVlYExLOhkN9cNS1T
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086331"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086331"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380333"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:56:09 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 4/6] fpga: dfl: configure port access mode for afu connected with port
Date:   Sun, 13 Mar 2022 06:52:40 -0400
Message-Id: <20220313105242.1567774-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220313105242.1567774-1-tianfei.zhang@intel.com>
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

In legacy model, we should set AfuAccessCtrl (Bit 55) in PORTn_OFFSET
register to switch VF and PF for AFU. But in "multiple VFs per PR slot"
model, the PF/VF mux hardware unit will statically configure the funciton
mapping without set the AfuAccessCtrl by software. This patch check the
port status in dfl_fpga_cdev->flags before configure the port access mode.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b95b29c5c81d..71e0725b6be0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1666,6 +1666,17 @@ static void config_port_access_mode(struct device *fme_dev, int port_id,
 #define config_port_vf_mode(dev, id) config_port_access_mode(dev, id, true)
 #define config_port_pf_mode(dev, id) config_port_access_mode(dev, id, false)
 
+static int dfl_check_port_connect_afu(struct device *dev, u64 flags)
+{
+	void __iomem *base;
+	int port;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	port = FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
+
+	return flags & dfl_feat_port_connect_afu(port);
+}
+
 /**
  * dfl_fpga_cdev_config_ports_pf - configure ports to PF access mode
  *
@@ -1683,7 +1694,9 @@ void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 		if (device_is_registered(&pdata->dev->dev))
 			continue;
 
-		config_port_pf_mode(cdev->fme_dev, pdata->id);
+		/* configure port access mode for AFU connected to Port device */
+		if (dfl_check_port_connect_afu(&pdata->dev->dev, cdev->flags))
+			config_port_pf_mode(cdev->fme_dev, pdata->id);
 	}
 	mutex_unlock(&cdev->lock);
 }
@@ -1722,7 +1735,9 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 		if (device_is_registered(&pdata->dev->dev))
 			continue;
 
-		config_port_vf_mode(cdev->fme_dev, pdata->id);
+		/* configure port access mode for AFU connected to Port device */
+		if (dfl_check_port_connect_afu(&pdata->dev->dev, cdev->flags))
+			config_port_vf_mode(cdev->fme_dev, pdata->id);
 	}
 done:
 	mutex_unlock(&cdev->lock);
-- 
2.26.2

