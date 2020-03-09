Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3067F17E791
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 19:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCISxb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 14:53:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41819 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISxb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Mar 2020 14:53:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id b5so10312748qkh.8
        for <linux-fpga@vger.kernel.org>; Mon, 09 Mar 2020 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0aYw0xE4DS1Zx3qR2CCtU5HwSoIMF/UkAcRwW7cUUWM=;
        b=CV69kTxe4FNYpWfHMjh6NRo6VIEgntz2BRjG4cNeT/UcG/h8+UJ9wfAybUT9u2M8kD
         60yGrcZyGdi2O8B1uzGOlBgs0LolgBmIgQa99pYuMuJ6k/y10ExRcDofA8ws1QeGZ4/W
         R5LeePR9D78B7iEpV+IoQvxf/zQwrTAZbeWC9fQDvNnb9HERqAqZ85iOYrzxQsu1rK2p
         IqRPi08Bo+HtXXR6rT/wulIpe5lzAUPyXlcsAf0GcH6X+Lwr0otGJySn4FCV4FMZvzk+
         gvjig8cLRSqx9WcE/bsy0Mipxi9MqkfWcnODxjkHJNPw9QQTGdaA6aCuyyjYXb87OvSD
         Jhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0aYw0xE4DS1Zx3qR2CCtU5HwSoIMF/UkAcRwW7cUUWM=;
        b=nGfeBZCRsAWIeDfd/TOsSYEbxUoIHHj3nIfh6Y5DYPCZqoYxBrxvi5zhu/HsUE8uCf
         ltoQiwz3jg0omslz+OUY5p2Zti5Ef7s6dX+g4bMHfSgjCha+rBv/S1QwnOaQSfEvw1Wt
         ALeSMdnpvy/OqqlICiDYR7SOSdxuUnWGed+8z138MKdVvGIjr8cpVxJ3H/jIbGsIVHeT
         GXsog+4mhDVSCjgRSDMhldEHcOT0EQHzSqPiY/C/ZhI/yR4KPMjkbeOr9KMtEoG8N2xT
         IjFrfIe7EWK5LmXQFZhzqN9119lyWUniI8VUQVT6QyLGznaM2RiRtpRGSjW1cCkgik6U
         bDPg==
X-Gm-Message-State: ANhLgQ0FKyEeZIafJuSXKPaR927ZMYMqcWrMbOGC+ukOyvRCrpYpQtmE
        a6jUmLu96dvvSy8x5gRALwE=
X-Google-Smtp-Source: ADFU+vuqGyS2DdZs0JJQV6d9Q8e/BTxqU0k7iBRW7y/Cbez94izMvtoTvpju4qX2fGqPCxBQn8fGRQ==
X-Received: by 2002:a05:620a:2209:: with SMTP id m9mr15901605qkh.71.1583780010771;
        Mon, 09 Mar 2020 11:53:30 -0700 (PDT)
Received: from localhost.localdomain (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.gmail.com with ESMTPSA id 11sm22265788qko.76.2020.03.09.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:53:30 -0700 (PDT)
From:   Dominic Chen <d.c.ddcc@gmail.com>
To:     hao.wu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Cc:     Dominic Chen <d.c.ddcc@gmail.com>
Subject: [PATCH v4] fpga: dfl: afu: support debug access to memory-mapped afu regions
Date:   Mon,  9 Mar 2020 14:53:23 -0400
Message-Id: <20200309185323.106443-1-d.c.ddcc@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Allow debug access to memory-mapped regions using e.g. gdb.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-afu-main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..d2e6826af970 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
+static const struct vm_operations_struct afu_vma_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;
 
+	/* Support debug access to the mapping */
+	vma->vm_ops = &afu_vma_ops;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-- 
2.17.1

