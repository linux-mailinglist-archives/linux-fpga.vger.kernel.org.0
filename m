Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9317918B
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Mar 2020 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgCDNjc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 08:39:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45235 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbgCDNjc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 08:39:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id a4so1306719qto.12
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2020 05:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BPCBXxqTr1Lx/tmRuEWrbtvpkP0658sF1L1RXdi3Pp8=;
        b=COT7Hk4oqUhvQ8lqZasxDBRaSXI6UWCO6x6TCGO8ttJtpEI3v+0JnjjKZMjsPQkGO4
         T8e5C69tbpMnUnxFD6V8JsUw7YgzcdE0mhWu9rHdcPh/XQQPQ9TuhxmWXVgdCrLw2ecX
         cXzcBqIBL/Om7GTncbia7jY/VNskVmIzjKqp7vWxwc+GQ5Cw3dbu3dUgVGX6z2v5FlGI
         ZePMpqfvCAUYvLXNpIjV0kz7i169JazwHLUEcA9IInJlOBJ25yjqkt+3bQqTfRSyXm1u
         VtaLpzZ38YHJ+ZCKOLKHlqSFiay3I05Eufmct8QiO/JXVULBt3OKZIeHcq4IvgZyxddQ
         knLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BPCBXxqTr1Lx/tmRuEWrbtvpkP0658sF1L1RXdi3Pp8=;
        b=QSWHmRwQf5MqrzVOc3rEnsxibSb9O4Ulv3bpp/r5Ajb8cUK8edr3R2b6O/9y80/s7i
         INT9Z+kdO3Fwvf2HgsDDJUkyxWx+Lc1nh1mO5VjpXClUDpWPS5W9LufuKb56H8VZc6xL
         A32vXesPN53VZHoNRdVL9zXyyyTSAq8EIzHBcYhEQ3hEWQt7Lpm5yDuq0/NuzKBJdee8
         UsoYzMgX6+AUVYHiON+z6y5cuc+2S/CT40qDaJvqrFIlQBKjCWhvVDZq527lencMrMjV
         0iQBj093qXAymyGud7D04wD43JBOMHxR+nGYW92golplhNq18+o56Mxgx5D0cx5ZPon5
         1G4A==
X-Gm-Message-State: ANhLgQ03uv0nbLwWa7tLkcrB2uiP7UEI0EVjx3xejK3LK+QW8tJt4SyH
        ygyeBAUXCQ7KPpOh/eybYFA=
X-Google-Smtp-Source: ADFU+vvOHJLdPEEuchZnji3yU1V86xD8H7iaW9lWAqrzlNritlE0wYQgPNi9fwh9LqZV/6CNWS0VLg==
X-Received: by 2002:ac8:44bb:: with SMTP id a27mr2381751qto.160.1583329171167;
        Wed, 04 Mar 2020 05:39:31 -0800 (PST)
Received: from localhost.localdomain (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.gmail.com with ESMTPSA id d1sm13719572qkj.29.2020.03.04.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 05:39:30 -0800 (PST)
From:   Dominic Chen <d.c.ddcc@gmail.com>
To:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     Dominic Chen <d.c.ddcc@gmail.com>
Subject: [PATCH v2] fpga: dfl: afu: support debug access to memory-mapped afu regions
Date:   Wed,  4 Mar 2020 08:38:47 -0500
Message-Id: <20200304133847.103881-1-d.c.ddcc@gmail.com>
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
index 02baa6a227c0..ec9dbd3d51b8 100644
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
 
+	// Support debug access to the mapping
+	vma->vm_ops = &afu_vma_ops;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-- 
2.17.1

