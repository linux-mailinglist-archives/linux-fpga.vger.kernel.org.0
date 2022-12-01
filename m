Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605363E7A5
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Dec 2022 03:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLACRk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Nov 2022 21:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiLACRj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Nov 2022 21:17:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3011170;
        Wed, 30 Nov 2022 18:17:38 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN08c4THtz4xVnZ;
        Thu,  1 Dec 2022 10:17:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B12HR1a083718;
        Thu, 1 Dec 2022 10:17:27 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 10:17:28 +0800 (CST)
Date:   Thu, 1 Dec 2022 10:17:28 +0800 (CST)
X-Zmail-TransId: 2af963880eb865dc48e1
X-Mailer: Zmail v1.0
Message-ID: <202212011017282887800@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <hao.wu@intel.com>
Cc:     <trix@redhat.com>, <mdf@kernel.org>, <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBmcGdhOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B12HR1a083718
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63880EC0.003 by FangMail milter!
X-FangMail-Envelope: 1669861056/4NN08c4THtz4xVnZ/63880EC0.003/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63880EC0.003/4NN08c4THtz4xVnZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/fpga/dfl-afu-main.c | 4 ++--
 drivers/fpga/dfl-fme-main.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..454fd4853000 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -155,7 +155,7 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int id = port_get_id(to_platform_device(dev));

-	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
+	return sysfs_emit(buf, "%d\n", id);
 }
 static DEVICE_ATTR_RO(id);

@@ -472,7 +472,7 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 	guidh = readq(base + GUID_H);
 	mutex_unlock(&pdata->lock);

-	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
+	return sysfs_emit(buf, "%016llx%016llx\n", guidh, guidl);
 }
 static DEVICE_ATTR_RO(afu_id);

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 77ea04d4edbe..50e1ed69b811 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -34,7 +34,7 @@ static ssize_t ports_num_show(struct device *dev,

 	v = readq(base + FME_HDR_CAP);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
 }
 static DEVICE_ATTR_RO(ports_num);
@@ -53,7 +53,7 @@ static ssize_t bitstream_id_show(struct device *dev,

 	v = readq(base + FME_HDR_BITSTREAM_ID);

-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)v);
 }
 static DEVICE_ATTR_RO(bitstream_id);

@@ -71,7 +71,7 @@ static ssize_t bitstream_metadata_show(struct device *dev,

 	v = readq(base + FME_HDR_BITSTREAM_MD);

-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)v);
 }
 static DEVICE_ATTR_RO(bitstream_metadata);

-- 
2.25.1
