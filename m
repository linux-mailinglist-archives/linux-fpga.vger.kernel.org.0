Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B641E38F18F
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhEXQad (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 12:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhEXQac (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 12:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iuHQv14n2tXxpqovyIKwtgyxu4mGC8IYavS7rpI9Oy4=;
        b=DA5NPzozmIeyY29B9mE/7jLYvX/3SDOEfOWhF5QRXqWsSvS0BsWYEpX3WtK94EZ3UgE+aN
        bIEijKy1F8kbNkGgmNsb/AF+wBPmqzLBb0U2PMwgXk+hGrLkothqewLZnLDXqbPxK3hqki
        afCT2JMi+bJA47aAjambhkH1Tzzz/Po=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-y7to9ujTOnifJDU_4Fyyvw-1; Mon, 24 May 2021 12:29:02 -0400
X-MC-Unique: y7to9ujTOnifJDU_4Fyyvw-1
Received: by mail-oo1-f69.google.com with SMTP id e17-20020a4a55110000b029020eb08e4aedso12183810oob.20
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuHQv14n2tXxpqovyIKwtgyxu4mGC8IYavS7rpI9Oy4=;
        b=N0VuWJdmK5oSb7JcWXieD18Kbtg5cOf3owrzfF/GqOaLTSwgBL5uQ5CVaIkQQKhW98
         ybfhCnrU6/g8kJUNvvLGEWCnQJW/elOeMZjzd6eOFYFqaQi0smIoY7VvRjIX8Vtj0NuJ
         nW94QBd7vMykQ7Kmyyp4njHcQcHhxGRdme2ug4gy5dj+RjwZjexfxSZ0vmQmy/vBIsWO
         9xo762S+p5ljhP811LKq93ul4YBoZ4nGn+DkXaeFiVTpgiZOC+MZvO4XQyuuuxGxlcHU
         /bJy4OTsfr6GZa8ZzOtr5M9LH5v+DySEz+Gus6lcp0E6tJoKkp56ProjMn/PeyElx2SB
         uCWA==
X-Gm-Message-State: AOAM531lBDARUrZOiq5QJSj+Bq7/91Dbbp3zOb97PzEOOwTTmr4mKapX
        p+Z68RTn9yJ7MCgwC5H7F7StyAanL7CuU96Bh+sptSmMtwAj4v57Fo7TeGID8+dODCYHK5f1bmo
        d9GR9+GYfVD0ITJqYLVPTIg==
X-Received: by 2002:a4a:b98e:: with SMTP id e14mr18812792oop.82.1621873741269;
        Mon, 24 May 2021 09:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTmqHUIDdCVBZGE0EV8HjMVsRSwgrvsrfeyd6RwEoiTCTj5mTJVeexy7zoapTfCbMk2Q2JwA==
X-Received: by 2002:a4a:b98e:: with SMTP id e14mr18812775oop.82.1621873741071;
        Mon, 24 May 2021 09:29:01 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v28sm2976981ood.27.2021.05.24.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:59 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 6/6] fpga: dfl: stub in reimaging
Date:   Mon, 24 May 2021 09:28:55 -0700
Message-Id: <20210524162855.2221757-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Generalize the pr writer to handle reimaging.  Rename the input structure
and add the DFL_FPGA_FME_REIMAGE ioctl.

Stub in reimage.write* ops

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c    | 28 ++++++++++++++++++++++++
 drivers/fpga/dfl-fme-pr.c     | 40 +++++++++++++++++++++--------------
 include/uapi/linux/fpga-dfl.h | 18 +++++++++++++---
 3 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 89913d27d877c..84bf431583005 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -252,6 +252,31 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int fme_mgr_reimage_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	struct device *dev = &mgr->dev;
+
+	if (!(info->flags & FPGA_MGR_REIMAGE)) {
+		dev_err(dev, "only supports reimaging.\n");
+		return -EINVAL;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int fme_mgr_reimage_write(struct fpga_manager *mgr,
+				 const char *buf, size_t count)
+{
+	return -EOPNOTSUPP;
+}
+
+static int fme_mgr_reimage_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
 static enum fpga_mgr_states fme_mgr_state(struct fpga_manager *mgr)
 {
 	return FPGA_MGR_STATE_UNKNOWN;
@@ -270,6 +295,9 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.reconfig.write_init     = fme_mgr_write_init,
 	.reconfig.write          = fme_mgr_write,
 	.reconfig.write_complete = fme_mgr_write_complete,
+	.reimage.write_init      = fme_mgr_reimage_write_init,
+	.reimage.write           = fme_mgr_reimage_write,
+	.reimage.write_complete  = fme_mgr_reimage_write_complete,
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 1194c0e850e07..2fc3ad92c8036 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -63,11 +63,11 @@ static struct fpga_region *dfl_fme_region_find(struct dfl_fme *fme, int port_id)
 	return region;
 }
 
-static int fme_pr(struct platform_device *pdev, unsigned long arg)
+static int fme_image(struct platform_device *pdev, unsigned long arg, bool pr)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __user *argp = (void __user *)arg;
-	struct dfl_fpga_fme_port_pr port_pr;
+	struct dfl_fpga_fme_image image;
 	struct fpga_image_info *info;
 	struct fpga_region *region;
 	void __iomem *fme_hdr;
@@ -78,12 +78,12 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	int ret = 0;
 	u64 v;
 
-	minsz = offsetofend(struct dfl_fpga_fme_port_pr, buffer_address);
+	minsz = offsetofend(struct dfl_fpga_fme_image, buffer_address);
 
-	if (copy_from_user(&port_pr, argp, minsz))
+	if (copy_from_user(&image, argp, minsz))
 		return -EFAULT;
 
-	if (port_pr.argsz < minsz || port_pr.flags)
+	if (image.argsz < minsz || image.flags)
 		return -EINVAL;
 
 	/* get fme header region */
@@ -91,25 +91,27 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 					       FME_FEATURE_ID_HEADER);
 
 	/* check port id */
-	v = readq(fme_hdr + FME_HDR_CAP);
-	if (port_pr.port_id >= FIELD_GET(FME_CAP_NUM_PORTS, v)) {
-		dev_dbg(&pdev->dev, "port number more than maximum\n");
-		return -EINVAL;
+	if (pr) {
+		v = readq(fme_hdr + FME_HDR_CAP);
+		if (image.port_id >= FIELD_GET(FME_CAP_NUM_PORTS, v)) {
+			dev_dbg(&pdev->dev, "port number more than maximum\n");
+			return -EINVAL;
+		}
 	}
 
 	/*
 	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
 	 * data automatically.
 	 */
-	length = ALIGN(port_pr.buffer_size, 4);
+	length = ALIGN(image.buffer_size, 4);
 
 	buf = vmalloc(length);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf,
-			   (void __user *)(unsigned long)port_pr.buffer_address,
-			   port_pr.buffer_size)) {
+			   (void __user *)(unsigned long)image.buffer_address,
+			   image.buffer_size)) {
 		ret = -EFAULT;
 		goto free_exit;
 	}
@@ -121,7 +123,10 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		goto free_exit;
 	}
 
-	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	if (pr)
+		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	else
+		info->flags |= FPGA_MGR_REIMAGE;
 
 	mutex_lock(&pdata->lock);
 	fme = dfl_fpga_pdata_get_private(pdata);
@@ -131,7 +136,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		goto unlock_exit;
 	}
 
-	region = dfl_fme_region_find(fme, port_pr.port_id);
+	region = dfl_fme_region_find(fme, pr ? image.port_id : 0);
 	if (!region) {
 		ret = -EINVAL;
 		goto unlock_exit;
@@ -141,7 +146,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 	info->buf = buf;
 	info->count = length;
-	info->region_id = port_pr.port_id;
+	info->region_id = image.port_id;
 	region->info = info;
 
 	ret = fpga_region_program_fpga(region);
@@ -457,7 +462,10 @@ static long fme_pr_ioctl(struct platform_device *pdev,
 
 	switch (cmd) {
 	case DFL_FPGA_FME_PORT_PR:
-		ret = fme_pr(pdev, arg);
+		ret = fme_image(pdev, arg, true);
+		break;
+	case DFL_FPGA_FME_REIMAGE:
+		ret = fme_image(pdev, arg, false);
 		break;
 	default:
 		ret = -ENODEV;
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index 1621b077bf212..2f633ca859763 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -214,7 +214,7 @@ struct dfl_fpga_irq_set {
 
 /**
  * DFL_FPGA_FME_PORT_PR - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 0,
- *						struct dfl_fpga_fme_port_pr)
+ *						struct dfl_fpga_fme_image)
  *
  * Driver does Partial Reconfiguration based on Port ID and Buffer (Image)
  * provided by caller.
@@ -224,13 +224,13 @@ struct dfl_fpga_irq_set {
  * from the status of FME's fpga manager.
  */
 
-struct dfl_fpga_fme_port_pr {
+struct dfl_fpga_fme_image {
 	/* Input */
 	__u32 argsz;		/* Structure length */
 	__u32 flags;		/* Zero for now */
 	__u32 port_id;
 	__u32 buffer_size;
-	__u64 buffer_address;	/* Userspace address to the buffer for PR */
+	__u64 buffer_address;	/* Userspace address to the buffer for image */
 };
 
 #define DFL_FPGA_FME_PORT_PR	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 0)
@@ -276,4 +276,16 @@ struct dfl_fpga_fme_port_pr {
 					     DFL_FME_BASE + 4,	\
 					     struct dfl_fpga_irq_set)
 
+/**
+ * DFL_FPGA_FME_REIMAGE - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 5,
+ *						struct dfl_fpga_fme_image)
+ *
+ * Driver reimages the whole board with the Buffer (Image) provided by caller.
+ * Return: 0 on success, -errno on failure.
+ * If DFL_FPGA_FME_REIMAGE returns -EIO, that indicates the HW has detected
+ * some errors during PR, under this case, the user can fetch HW error info
+ * from the status of FME's fpga manager.
+ */
+#define DFL_FPGA_FME_REIMAGE	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 5)
+
 #endif /* _UAPI_LINUX_FPGA_DFL_H */
-- 
2.26.3

