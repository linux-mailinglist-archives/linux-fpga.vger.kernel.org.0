Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223CD1B4371
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Apr 2020 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgDVLoe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Apr 2020 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgDVLoe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Apr 2020 07:44:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8525C03C1A8
        for <linux-fpga@vger.kernel.org>; Wed, 22 Apr 2020 04:44:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jRDns-0000Vu-Fg; Wed, 22 Apr 2020 13:44:32 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jRDns-00051i-4t; Wed, 22 Apr 2020 13:44:32 +0200
Date:   Wed, 22 Apr 2020 13:44:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: How to upload fpga firmware
Message-ID: <20200422114432.GM1694@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:41:04 up 62 days, 19:11, 111 users,  load average: 0.21, 0.16,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

I wonder what can be done with the mainline state of drivers/fpga/. The
entry to the framework seems to be fpga_mgr_load(). The only user of
this function is fpga_region_program_fpga(). This in turn is only called
in response of applying a device tree overlay. A device tree overlay is
applied with of_overlay_fdt_apply() which has no users in the Kernel.

My current task is to load a firmware to a FPGA. The code all seems to
be there in the Kernel, it only lacks a way to trigger it. I am not very
interested in device tree overlays since the FPGA appears as a PCI
device (although applying a dtbo could enable the PCIe controller device
tree node). Is there some mainline way to upload FPGA firmware? At the
moment we are using the attached patch to trigger loading the firmware
from userspace. Would something like this be acceptable for mainline?

Sascha

---------------------------8<----------------------------------

From 71a5ea845dd673d4011391f9e57fdaf427767ed5 Mon Sep 17 00:00:00 2001
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 2 Oct 2018 17:13:40 +0200
Subject: [PATCH] fpga: region: Add sysfs attribute for loading firmware

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/fpga/fpga-region.c | 50 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index bde5a9d460c5..ca6dc830fadf 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
  */
+#include <linux/device.h>
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
@@ -170,11 +171,58 @@ static ssize_t compat_id_show(struct device *dev,
 		       (unsigned long long)region->compat_id->id_h,
 		       (unsigned long long)region->compat_id->id_l);
 }
-
 static DEVICE_ATTR_RO(compat_id);
 
+static ssize_t firmware_name_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+
+	if (!region->info || !region->info->firmware_name)
+		return 0;
+
+	return sprintf(buf, "%s\n", region->info->firmware_name);
+}
+
+static ssize_t firmware_name_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *firmware_name, size_t count)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	struct fpga_image_info *info = region->info;
+	int error;
+
+	if (!info) {
+		info = fpga_image_info_alloc(dev);
+		if (!info)
+			return -ENOMEM;
+	} else if (info->firmware_name) {
+		devm_kfree(dev, info->firmware_name);
+	}
+
+	info->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
+	if (!info->firmware_name)
+		return -ENOMEM;
+
+	if (count >  0 && info->firmware_name[count - 1] == '\n')
+		info->firmware_name[count - 1] = '\0';
+
+	region->info = info;
+	error = fpga_region_program_fpga(region);
+	if (error) {
+		devm_kfree(dev, info->firmware_name);
+		info->firmware_name = NULL;
+	}
+
+	return error ? error : count;
+}
+
+static DEVICE_ATTR_RW(firmware_name);
+
 static struct attribute *fpga_region_attrs[] = {
 	&dev_attr_compat_id.attr,
+	&dev_attr_firmware_name.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_region);
-- 
2.26.1

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
