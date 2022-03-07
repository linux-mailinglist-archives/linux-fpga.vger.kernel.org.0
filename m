Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54B54D0033
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiCGNhF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiCGNhE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:37:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051EE7F6C1;
        Mon,  7 Mar 2022 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660170; x=1678196170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YpQOqJr+UAcXIMvGotvfcbt1GLgJVE0IwnhYKEyAfew=;
  b=KoxADW6f3Ky8FfhIWTYsKTvLnkd+ukCPE6jMJPiqliCGTB5sq3LpRtUn
   s1ZTwZEMhknuF0m1fV79wJ9yj0odFd3eQ60C4CLhT7SEA8hQ1QsqotjRW
   ZvxmRflolOtnq3TA8S1SHnhMz36Ei/X6ETp/xxyq0I7u3y0+L5fZtfcid
   LOBowChsdl/iGa+SYobcMYzm2nNhhN7kHZZtgSS2jSJyUB3lmtTAI4Jxt
   riDWbcI796gHszCPhO/FgR6Z10ETgOAopMP9XhPGNLKwkGbQNEMUSDQQO
   wA/Fsy20HLiPkc77nV92r1g0RhrCDJj7rj0ZWrbmxQXfg2S0cMI4xcrWt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579349"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643246996"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:36:08 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 4/6] fpga: dfl: configure port access mode for afu connected with port
Date:   Mon,  7 Mar 2022 08:32:41 -0500
Message-Id: <20220307133243.1426300-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220307133243.1426300-1-tianfei.zhang@intel.com>
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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

