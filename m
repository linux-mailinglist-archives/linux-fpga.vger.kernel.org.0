Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCE178A80
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Mar 2020 07:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgCDGON (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 01:14:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44742 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDGON (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 01:14:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id f198so510936qke.11
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2020 22:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Q06ydP/oVUWISQnfAf79Y8zcGSgEU7zPSQ0P5PbknA=;
        b=LJSvdX8fIOKBxQpNj5F9sgfJp4h4w+F6knzAUd/2LWLXVY2PD8eddQs3LQRepARwdz
         Nm59wC544retoP7Kjb47ZNLhUB3Q4Mu1kYgBAl/IpeUocoM+dY8NZIbiBFzO74c4QbrT
         qA/ZbosxLxAcXxR9QYHQOYn4Y1FSulRUt0aoBiuF3mWZZYaO5u61Z6rgjJ/S2rfYNz/b
         Ew/7ldGK9KknOsP6Wa6Edm39fJTWBxbSV9CGcQndZnxNqnvXthVLTfpap+X4L/ivqcKm
         McnUqaSPN+0ri4RehNdolHo+HHVcoM1XwKbukvNZvKm5MWkcB2R8k1MFc16WmAsiTo2x
         0bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Q06ydP/oVUWISQnfAf79Y8zcGSgEU7zPSQ0P5PbknA=;
        b=rIk38oVbrIv1iQto4UjKF322L0xv7gc+zdLfCGwaZmTH3dtbeyz/WIFikLmEaG7KEg
         FrnXZj/25iksOkEvltPAwMmHSBLGb2BGGkpxAokPll8z7k2j7ATOgnZ2MPkHSvwcOxCN
         np2lc+pFURpaTr/3ucsPMZsGRSAZfQheCuFk+eCXiaeHwvqfMVdzFXAOWCGNACDYNwDO
         68ZGXTf7gNArWSS1NyiVV9MDexnOzkhNfRNnlGpY1P/WNR9JlIvZOsY+NJEoBSeX5S72
         uBgKpi2tkmdAjdG70qJiG8xvtOQaYpJwJdO7mkaazW8BmMn8AlVRk7nRUcRldNgPOe1f
         rR4Q==
X-Gm-Message-State: ANhLgQ0i2bXD84angz6gd9wuLKp6jFqcXkibR4DadokyL8jJm6UVRPbs
        oIQFIxJDdlMAM+xM08G9nrl9KiN4
X-Google-Smtp-Source: ADFU+vtmutJLofjgSTbqnlFg+piNRq8YIafn6kZruwLwT77a9RXlaftRHHbB217ktP4HJsyc1Nozaw==
X-Received: by 2002:a37:b842:: with SMTP id i63mr1478976qkf.451.1583302452608;
        Tue, 03 Mar 2020 22:14:12 -0800 (PST)
Received: from localhost.localdomain (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.gmail.com with ESMTPSA id o127sm13561676qke.92.2020.03.03.22.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 22:14:11 -0800 (PST)
From:   Dominic Chen <d.c.ddcc@gmail.com>
To:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     Dominic Chen <d.c.ddcc@gmail.com>
Subject: [Resend] [PATCH] fpga: support debug access to memory-mapped afu regions
Date:   Wed,  4 Mar 2020 01:14:06 -0500
Message-Id: <20200304061406.98865-1-d.c.ddcc@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Allow debug access to memory-mapped regions using e.g. gdb.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
---
 drivers/fpga/dfl-afu-main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..38983f9dde98 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+const struct vm_operations_struct afu_vma_ops = {
+	.access = generic_access_phys,
+};
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
+
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;
 
+	// Support debug access to the mapping
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	vma->vm_ops = &afu_vma_ops;
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-- 
2.17.1

