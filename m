Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9B3BF09E
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Jul 2021 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhGGULx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Jul 2021 16:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhGGULx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Jul 2021 16:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625688552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dlshEtXmc0jULoT3N3z0USnZgLOuwGT8Sv+EBVGoygU=;
        b=AJG2gy1vkoS3umtam0n1LyX9R2skXspuf6lfglh+epckGgmYTyLHDahaLm6THmeyFq9+1D
        ISMDuCM3CRMosB5lhUfR94C5K2L6hrXYJeMVYVHYnVipJkdhqj9KdsEs5B9sOmCzHeiR5e
        rrfs+elc9TA5gukwS8Wqzmjl1R82Sv4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-pr71VpNmPCambgUdyco8Mw-1; Wed, 07 Jul 2021 16:09:11 -0400
X-MC-Unique: pr71VpNmPCambgUdyco8Mw-1
Received: by mail-oo1-f70.google.com with SMTP id v24-20020a4ac9180000b02902589f63056aso2167784ooq.5
        for <linux-fpga@vger.kernel.org>; Wed, 07 Jul 2021 13:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlshEtXmc0jULoT3N3z0USnZgLOuwGT8Sv+EBVGoygU=;
        b=T40LH+dIkWLH5bv/lVeDoMBfmQqZGkdvJsaxs2KMXljyf0Lswyxj92qp6/hLhxmjCx
         Qqf+lPXCzJDuXQqUvrQiAXTeVU6FmpKG4Y1Chpa1llduE0dnGYac2fRbb7DJj7cwBiWS
         Sy8Wom38MrGasgOBZECZVwLjlLzOl20SQmg3ImhU3CXNJwsqBy/y10j3WL3PWlpL6X3a
         aQ4kxzGVW71Sf+vL8zMpdL0/NmAw/Z3iwNZZLQRTZvQxDjacGgyeXTTkMOjfj5thIdD7
         qlMxRWjD4occCqXFFy6LB9/iAU42RjkWcn+tDnhWOf795Whoqh+68GS2wRA7zPQuSh+Y
         Kxnw==
X-Gm-Message-State: AOAM5309B9TfC+ikxHA3YX8tJM4JLHq33bwTCX7V907sZxepXKUWWo68
        ctV41A6FfAzjzb1OIYeTSgQetaV8wSbFd4C21Ypk4VEQ6WtHOjJIgPrRsoN+x4uFM1IPEXCO8Ju
        7Jv2vJYR+t+BxVc21lnekjw==
X-Received: by 2002:a9d:7745:: with SMTP id t5mr15270475otl.238.1625688550333;
        Wed, 07 Jul 2021 13:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7qwGWm/U4gW1eYCu8Dc6/bKY7zSqKx7DPkB/Yal/mVK9AoivmyxsN5blfdZNhtsck51EjYA==
X-Received: by 2002:a9d:7745:: with SMTP id t5mr15270458otl.238.1625688550079;
        Wed, 07 Jul 2021 13:09:10 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b80sm28951oii.3.2021.07.07.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:09:09 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: fpga-mgr: move compat_id from fpga_mgr to dfl
Date:   Wed,  7 Jul 2021 13:09:02 -0700
Message-Id: <20210707200902.2014298-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

fpga_mgr's element compat_id is only used by dfl.
Implementation specific data should not be stored
in common structures.  So move it to dfl.

dfl_fme_mgr reads its compat_id register and makes a copy.
dfl_fme_region reads dfl_fme_mgr's value and makes a copy,
then region outputs the value to sysfs.  There is no other
use.  Instead of making copies and passing them around, output
the compat_id directly in dfl_fme_mgr.

The sysfs change is from
/sys/class/fpga_region/region0/compat_id
to
/sys/class/fpga_region/region0/dfl-fme.0/dfl-fme-mgr.0/compat_id

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../ABI/testing/sysfs-class-fpga-region       |  9 -----
 Documentation/fpga/dfl.rst                    |  2 +-
 drivers/fpga/dfl-fme-mgr.c                    | 34 ++++++++++++-------
 drivers/fpga/dfl-fme-region.c                 |  1 -
 drivers/fpga/fpga-region.c                    | 22 ------------
 include/linux/fpga/fpga-mgr.h                 | 13 -------
 include/linux/fpga/fpga-region.h              |  2 --
 7 files changed, 22 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
deleted file mode 100644
index bc7ec644acc9..000000000000
--- a/Documentation/ABI/testing/sysfs-class-fpga-region
+++ /dev/null
@@ -1,9 +0,0 @@
-What:		/sys/class/fpga_region/<region>/compat_id
-Date:		June 2018
-KernelVersion:	4.19
-Contact:	Wu Hao <hao.wu@intel.com>
-Description:	FPGA region id for compatibility check, e.g. compatibility
-		of the FPGA reconfiguration hardware and image. This value
-		is defined or calculated by the layer that is creating the
-		FPGA region. This interface returns the compat_id value or
-		just error code -ENOENT in case compat_id is not used.
diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 75df90d1e54c..bca36060de29 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -246,7 +246,7 @@ generated for the exact static FPGA region and targeted reconfigurable region
 (port) of the FPGA, otherwise, the reconfiguration operation will fail and
 possibly cause system instability. This compatibility can be checked by
 comparing the compatibility ID noted in the header of PR bitstream file against
-the compat_id exposed by the target FPGA region. This check is usually done by
+the compat_id exposed by the target FME. This check is usually done by
 userspace before calling the reconfiguration IOCTL.
 
 
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b306..62d558b44ae6 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -272,17 +272,31 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.status = fme_mgr_status,
 };
 
-static void fme_mgr_get_compat_id(void __iomem *fme_pr,
-				  struct fpga_compat_id *id)
+static ssize_t compat_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
-	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
-	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
+	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(dev);
+	u64 l, h;
+
+	l = readq(pdata->ioaddr + FME_PR_INTFC_ID_L);
+	h = readq(pdata->ioaddr + FME_PR_INTFC_ID_H);
+
+	return sysfs_emit(buf, "%016llx%016llx\n",
+			  (unsigned long long)h,
+			  (unsigned long long)l);
 }
 
+static DEVICE_ATTR_RO(compat_id);
+
+static struct attribute *fme_mgr_attrs[] = {
+	&dev_attr_compat_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fme_mgr);
+
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct fpga_compat_id *compat_id;
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
@@ -300,27 +314,21 @@ static int fme_mgr_probe(struct platform_device *pdev)
 		priv->ioaddr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(priv->ioaddr))
 			return PTR_ERR(priv->ioaddr);
+		pdata->ioaddr = priv->ioaddr;
 	}
 
-	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
-	if (!compat_id)
-		return -ENOMEM;
-
-	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
-
 	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
 				   &fme_mgr_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
-	mgr->compat_id = compat_id;
-
 	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static struct platform_driver fme_mgr_driver = {
 	.driver	= {
 		.name    = DFL_FPGA_FME_MGR,
+		.dev_groups = fme_mgr_groups,
 	},
 	.probe   = fme_mgr_probe,
 };
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..4825639a3845 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -46,7 +46,6 @@ static int fme_region_probe(struct platform_device *pdev)
 	}
 
 	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
 	ret = fpga_region_register(region);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index a4838715221f..c971f76ca61a 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -158,27 +158,6 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
-static ssize_t compat_id_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct fpga_region *region = to_fpga_region(dev);
-
-	if (!region->compat_id)
-		return -ENOENT;
-
-	return sprintf(buf, "%016llx%016llx\n",
-		       (unsigned long long)region->compat_id->id_h,
-		       (unsigned long long)region->compat_id->id_l);
-}
-
-static DEVICE_ATTR_RO(compat_id);
-
-static struct attribute *fpga_region_attrs[] = {
-	&dev_attr_compat_id.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(fpga_region);
-
 /**
  * fpga_region_create - alloc and init a struct fpga_region
  * @parent: device parent
@@ -328,7 +307,6 @@ static int __init fpga_region_init(void)
 	if (IS_ERR(fpga_region_class))
 		return PTR_ERR(fpga_region_class);
 
-	fpga_region_class->dev_groups = fpga_region_groups;
 	fpga_region_class->dev_release = fpga_region_dev_release;
 
 	return 0;
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ec2cd8bfceb0..ebdea215a864 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -143,24 +143,12 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
-/**
- * struct fpga_compat_id - id for compatibility check
- *
- * @id_h: high 64bit of the compat_id
- * @id_l: low 64bit of the compat_id
- */
-struct fpga_compat_id {
-	u64 id_h;
-	u64 id_l;
-};
-
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
- * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
  */
@@ -169,7 +157,6 @@ struct fpga_manager {
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
-	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275db..b008d5a300fd 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -14,7 +14,6 @@
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
  * @info: FPGA image info
- * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -24,7 +23,6 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
-	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
-- 
2.26.3

