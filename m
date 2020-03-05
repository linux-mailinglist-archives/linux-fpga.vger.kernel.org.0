Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49904179E45
	for <lists+linux-fpga@lfdr.de>; Thu,  5 Mar 2020 04:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgCEDdT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 22:33:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36679 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEDdT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 22:33:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id u25so3989348qkk.3
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2020 19:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E/CuyYN9YCfSLv7l2gZUHMfuHJ2zXaJs7KGXwu48qMw=;
        b=QAl0PAJWGrps5jhzwhaxy6oCO2Jy6P8Mtd/cU78P+ZSturzBgE57XYlCnyVIfGnyvb
         5jVHsAf99S9SbXqIM5YUi6Ab82zonbqAiPkJBLYzyaFJK1S46xaC9A7K1ZUTlEwkK6t/
         jbvDv3iZOet+VhcRF0ypqONs2KoJLJwTbcwFNKEHoPgJwvGW1VwvxZtVOiIYjnckVvWc
         mhKx8t7SJSqIlxbCuF6NYO9WAHMaT0MOZrdDJ0BcLBZ4F2pY9p2mLt07IA5QAfPYwl8B
         KGYULlfDb+VS9znkK9P7rrEcF+Ljxbvt+TOug4jyYDtrgmNzPOzEVYp/fOMVrBoafLW6
         bPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E/CuyYN9YCfSLv7l2gZUHMfuHJ2zXaJs7KGXwu48qMw=;
        b=fPuqDwF/Leassmm6ifc9PubJUWMFD6o/Rgv+MkrUNPp9oYBdjnN3iuwKKYpV7aV3Mz
         x0VfBmD+Iab1PTDoQMJlliaQvOdhwlE2SrD1h+F5ZknE6iKREnD38Nb37/OSuwN94PDM
         sl1NezMqKMndTUxUnPn8TU/mG0ft848yYn49FRobvgGspDIdYhMxGxLBvuFP8Z/s/E6N
         yfsA7woNK+8HARDyzTkGmyDFcdkqGUqgwp/9rj+2IO9IG+DlT4NR3dv5RjcLcoxFjjYN
         fv0HU9f+4p1DFR7VzDgFTjsQhe0aLO67dZz5Xt+agnE574XEzzWz7R2gmpORLdLKKHdX
         UF8Q==
X-Gm-Message-State: ANhLgQ0bns1T00+EGLKoiBA7hP20lqIMOXhN6We6CRB14ddzfX5g0Lci
        q7YYUfPl0RhX08Fu8IcncYQ=
X-Google-Smtp-Source: ADFU+vtbrVUuyaEdis92OsBpwX7LuWyyCcjXR6B89iEIDVJs9wSduIFjru0yLdbXFEsHJB+bXJHcTw==
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr6354384qkk.285.1583379198542;
        Wed, 04 Mar 2020 19:33:18 -0800 (PST)
Received: from localhost.localdomain (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.gmail.com with ESMTPSA id y197sm14836549qka.65.2020.03.04.19.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 19:33:17 -0800 (PST)
From:   Dominic Chen <d.c.ddcc@gmail.com>
To:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     Dominic Chen <d.c.ddcc@gmail.com>
Subject: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped afu regions
Date:   Wed,  4 Mar 2020 22:33:10 -0500
Message-Id: <20200305033310.117030-1-d.c.ddcc@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Allow debug access to memory-mapped regions using e.g. gdb.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
---
 drivers/fpga/dfl-afu-main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..8fa1666b5b20 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
+static const struct vm_operations_struct afu_vma_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
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

