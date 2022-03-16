Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D24DABB0
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiCPHNM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354265AbiCPHNB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:13:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548115DE54;
        Wed, 16 Mar 2022 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414708; x=1678950708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iLyZDvemV1Z1JW/SXRxgwjuzRQL+/0fI6UJa6N3g8s0=;
  b=B0+PRNBPqdVA6arFi49I1gvnscUC3fCYQrHTM3Skib2D2H35ze7n9XMG
   75C+53ZjDZG7A+zLpQ9/io2eukmzbT1vWPAMV0fzI2c1V2/Jhy5W1SHT3
   +7JX9dqgsxnep4J5LYvAexQNl96easQ7kd5gPYz4Oic1TUAh7QDIM3yCU
   5cNYqEBuNSUdsvGxqcvFy77msnUOQSRxB9cStjog8EtnyCf+JV32Mc7Sw
   f+cbgJFjjB/uHkiflMW4FRUu4HBkpXL77WRz56BzNSNe8VTIIuOjT+XvO
   fTfs+TgD7wZpb3R+aXxs+VmmWle3otRzAIUt8S0s7Nqtsg/Q3s9If/49B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289052"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289052"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538374"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:45 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 4/6] fpga: dfl: configure port access mode for afu connected with port
Date:   Wed, 16 Mar 2022 03:08:12 -0400
Message-Id: <20220316070814.1916017-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
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

